import logger from './logger';
import soundPlayer from './soundPlayer';
import clientSender from '../mixins/clientSender';
export default {
    created: function() {
        // Create listener for incoming messages coming from
        // client Lua
        window.addEventListener('message', event => this.processMessage(event));
    },
    destroyed: function() {
        // Destroy listener for incoming messages coming from
        // client Lua
        window.removeEventListener('message', event =>
            this.processMessage(event)
        );
    },
    mixins: [logger, soundPlayer, clientSender],
    methods: {
        userIsAssignedToCall(panicCallId) {
            const user = this.$store.getters.getUser;
            // Get the units assigned to the panic call
            const allCalls = this.$store.getters.getCalls;
            const call = allCalls.find(
                call => parseInt(call.id) === parseInt(panicCallId)
            );
            const assignedUnits = call.assignedUnits.map(assUnit =>
                parseInt(assUnit.id)
            );
            // We have a list of units assigned to the call
            // We have a list of all user / unit assignments
            //
            // - Get a list of unit assignments for this user
            const usersUnits = this.$store.getters.getUserUnits.filter(
                uu => uu.UserId === user.id
            );
            // - Check if any of those units intersect with units assigned to the call
            return (
                usersUnits.filter(usersUnit =>
                    assignedUnits.includes(parseInt(usersUnit.UnitId))
                ).length > 0
            );
        },
        // We may need to update the active marker and route when a call changed
        updateMarkerRoute() {
            const activeMarker = this.$store.getters.getActiveMarker;
            if (activeMarker !== -1) {
                const calls = this.$store.getters.getCalls;
                const call = calls.find(c => c.id === activeMarker);
                if (call) {
                    this.sendClientMessage('setCallMarker', {
                        call
                    });
                } else {
                    // The call may have been removed, in which case we want to
                    // remove the marker
                    this.sendClientMessage('clearCallMarker', {
                        call
                    });
                }
            }
            const activeRoute = this.$store.getters.getActiveRoute;
            if (activeRoute !== -1) {
                const calls = this.$store.getters.getCalls;
                const call = calls.find(c => c.id === activeRoute);
                if (call) {
                    this.sendClientMessage('setCallRoute', {
                        call
                    });
                } else {
                    // The call may have been removed, in which case we want to
                    // remove the route
                    this.sendClientMessage('clearCallRoute', {
                        call
                    });
                }
            }
        },
        // Handler for incoming messages from client Lua
        processMessage() {
            this.doLog('PROCESSING MESSAGE ' + JSON.stringify(event.data));
            if (event.data.hasOwnProperty('action')) {
                if (event.data.action == 'showMdt') {
                    this.$store.commit('setVisible');
                }
                if (event.data.action == 'openTerminal') {
                    this.$store.commit('setTerminalVisible', true);
                }
                if (event.data.action == 'closeTerminal') {
                    this.$store.commit('setTerminalVisible', false);
                }
                if (event.data.action == 'terminalDraggingOn') {
                    this.$store.commit('setTerminalDragging', true);
                }
                if (event.data.action == 'terminalDraggingOff') {
                    this.$store.commit('setTerminalDragging', false);
                }
                if (event.data.action == 'openCall') {
                    this.$store.commit('setCallVisible', true);
                }
                if (event.data.action == 'closeCall') {
                    this.$store.commit('setCallVisible', false);
                }
            } else if (event.data.hasOwnProperty('data')) {
                // Identify what sort of data we're receiving
                if (event.data.hasOwnProperty('object') && event.data.object) {
                    // Animate the "receiving" indicator
                    this.$store.commit('setConnectionIsActive');
                    switch (event.data.object) {
                        case 'config':
                            this.doLog('RECEIVED CONFIG');
                            this.$store.commit(
                                'setResourceConfig',
                                event.data.data
                            );
                            break;
                        case 'units':
                            this.doLog('RECEIVED UNITS');
                            this.$store.commit('setUnits', event.data.data);
                            break;
                        case 'display_panic':
                            this.doLog('RECEIVED PANIC CALL ID');
                            this.$store.dispatch(
                                'setPanicIsActive',
                                event.data.data
                            );
                            const officer = this.$store.getters
                                .getActiveOfficer;
                            if (officer) {
                                this.playPanic();
                            }
                            const conf = this.$store.getters.getResourceConfig;
                            const panicCallId = parseInt(
                                event.data.data.call_id
                            );
                            if (
                                this.userIsAssignedToCall(panicCallId) &&
                                conf.panic_create_marker
                            ) {
                                const calls = this.$store.getters.getCalls;
                                const call = calls.find(
                                    c => parseInt(c.id) === panicCallId
                                );
                                this.sendClientMessage('setCallMarker', {
                                    call
                                });
                                this.sendClientMessage('setCallRoute', {
                                    call
                                });
                                this.$store.commit('setActiveMarker', call.id);
                                this.$store.commit('setActiveRoute', call.id);
                            }
                            break;
                        case 'unit_states':
                            this.doLog('RECEIVED UNIT STATES');
                            this.$store.commit(
                                'setUnitStates',
                                event.data.data
                            );
                            break;
                        case 'unit_types':
                            this.doLog('RECEIVED UNIT TYPES');
                            this.$store.commit(
                                'setUnitTypes',
                                event.data.data
                            );
                            break;
                        case 'users':
                            this.doLog('RECEIVED USERS');
                            this.$store.commit('setUsers', event.data.data);
                            break;
                        case 'calls':
                            this.doLog('RECEIVED CALLS');
                            this.$store.commit('setCalls', event.data.data);
                            this.updateMarkerRoute();
                            break;
                        case 'user_units':
                            this.doLog('RECEIVED USER_UNITS');
                            this.$store.commit('setUserUnits', event.data.data);
                            break;
                        case 'user_ranks':
                            this.doLog('RECEIVED USER_RANKS');
                            this.$store.commit('setUserRanks', event.data.data);
                            break;
                        case 'citizen_markers':
                            this.doLog('RECEIVED CITIZEN_MARKERS');
                            this.$store.commit(
                                'setCitizenMarkers',
                                event.data.data
                            );
                            break;
                        case 'vehicle_markers':
                            this.doLog('RECEIVED VEHICLE_MARKERS');
                            this.$store.commit(
                                'setVehicleMarkers',
                                event.data.data
                            );
                            break;
                        case 'charges':
                            this.doLog('RECEIVED CHARGES');
                            this.$store.commit('setCharges', event.data.data);
                            break;
                        case 'locations':
                            this.doLog('RECEIVED LOCATIONS');
                            this.$store.commit('setLocations', event.data.data);
                            break;
                        case 'call_grades':
                            this.doLog('RECEIVED CALL GRADES');
                            this.$store.commit(
                                'setCallGrades',
                                event.data.data
                            );
                            break;
                        case 'call_types':
                            this.doLog('RECEIVED CALL TYPES');
                            this.$store.commit(
                                'setCallTypes',
                                event.data.data
                            );
                            break;
                        case 'call_incidents':
                            this.doLog('RECEIVED CALL INCIDENTS');
                            this.$store.commit(
                                'setCallIncidents',
                                event.data.data
                            );
                            break;
                        case 'vehicle_models':
                            this.doLog('RECEIVED VEHICLE_MODELS');
                            this.$store.commit(
                                'setVehicleModels',
                                event.data.data
                            );
                            break;
                        case 'steam_id':
                            this.doLog('RECEIVED STEAM ID');
                            this.$store.commit('setSteamId', event.data.data);
                            break;
                        case 'citizen_search_results':
                            this.doLog('RECEIVED CITIZEN SEARCH RESULTS');
                            this.$store.commit(
                                'setCitizenSearchResultsInitial',
                                event.data.data
                            );
                            break;
                        case 'citizen':
                            this.doLog('RECEIVED CITIZEN');
                            this.$store.commit(
                                'setCitizenOffences',
                                event.data.data
                            );
                            break;
                        case 'vehicle_search_results':
                            this.doLog('RECEIVED VEHICLE SEARCH RESULTS');
                            this.$store.commit(
                                'setVehicleSearchResults',
                                event.data.data
                            );
                            break;
                        case 'citizen_offences':
                            this.doLog('RECEIVED CITIZEN OFFENCES');
                            const parsed = JSON.parse(event.data.data);
                            this.$store.commit(
                                'setCitizenOffences',
                                parsed.data.getCitizen
                            );
                            break;
                        default:
                            this.doLog('Unknown object received');
                    }
                }
            }
        }
    }
};
