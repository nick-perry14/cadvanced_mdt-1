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
    methods: {
        // Handler for incoming messages from client Lua
        // const event = new Event('message');event.data = {action:'showMdt'};window.dispatchEvent(event);
        processMessage() {
            console.log(
                'NUI: PROCESSING MESSAGE ' + JSON.stringify(event.data)
            );
            if (
                event.data.hasOwnProperty('action') &&
                event.data.action == 'showMdt'
            ) {
                this.$store.commit('setVisible');
            } else if (event.data.hasOwnProperty('data')) {
                // Identify what sort of data we're receiving
                if (event.data.hasOwnProperty('object') && event.data.object) {
                    // Animate the "receiving" indicator
                    this.$store.commit('setConnectionIsActive');
                    switch (event.data.object) {
                        case 'config':
                            console.log('NUI: RECEIVED CONFIG');
                            this.$store.commit(
                                'setResourceConfig',
                                event.data.data
                            );
                            break;
                        case 'units':
                            console.log('NUI: RECEIVED UNITS');
                            this.$store.commit('setUnits', event.data.data);
                            break;
                        case 'unit_states':
                            console.log('NUI: RECEIVED UNIT STATES');
                            this.$store.commit(
                                'setUnitStates',
                                event.data.data
                            );
                            break;
                        case 'users':
                            console.log('NUI: RECEIVED USERS');
                            this.$store.commit('setUsers', event.data.data);
                            break;
                        case 'calls':
                            console.log('NUI: RECEIVED CALLS');
                            this.$store.commit('setCalls', event.data.data);
                            break;
                        case 'user_units':
                            console.log('NUI: RECEIVED USER_UNITS');
                            this.$store.commit('setUserUnits', event.data.data);
                            break;
                        case 'user_ranks':
                            console.log('NUI: RECEIVED USER_RANKS');
                            this.$store.commit('setUserRanks', event.data.data);
                            break;
                        case 'citizen_markers':
                            console.log('NUI: RECEIVED CITIZEN_MARKERS');
                            this.$store.commit(
                                'setCitizenMarkers',
                                event.data.data
                            );
                            break;
                        case 'vehicle_markers':
                            console.log('NUI: RECEIVED VEHICLE_MARKERS');
                            this.$store.commit(
                                'setVehicleMarkers',
                                event.data.data
                            );
                            break;
                        case 'vehicle_models':
                            console.log('NUI: RECEIVED VEHICLE_MODELS');
                            this.$store.commit(
                                'setVehicleModels',
                                event.data.data
                            );
                            break;
                        case 'steam_id':
                            console.log('NUI: RECEIVED STEAM ID');
                            this.$store.commit('setSteamId', event.data.data);
                            break;
                        case 'citizen_search_results':
                            console.log('NUI: RECEIVED CITIZEN SEARCH RESULTS');
                            this.$store.commit(
                                'setCitizenSearchResults',
                                event.data.data
                            );
                            break;
                        case 'vehicle_search_results':
                            console.log('NUI: RECEIVED VEHICLE SEARCH RESULTS');
                            this.$store.commit(
                                'setVehicleSearchResults',
                                event.data.data
                            );
                            break;
                        case 'citizen_offences':
                            console.log('NUI: RECEIVED CITIZEN OFFENCES');
                            this.$store.commit(
                                'setCitizenOffences',
                                event.data.data
                            );
                            break;
                        default:
                            console.log('NUI: Unknown object received');
                    }
                }
            }
        }
    }
};
