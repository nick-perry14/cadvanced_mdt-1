import Vue from 'vue';
import Vuex from 'vuex';

import logger from '../mixins/logger';

Vue.use(Vuex);

const modalsInit = {
    offence: {
        open: false
    },
    call: {
        open: false
    },
    ranks: {
        open: false
    },
    unitStates: {
        open: false
    },
    markers: {
        open: false
    },
    comingSoon: {
        open: false
    }
};

const reconstructOffences = offences => {
    return offences.map(offence => {
        if (!offence.arrest) {
            offence.arrest = {
                id: null,
                date: '',
                time: '',
                officer: {},
                OfficerId: null,
                charges: []
            };
        }
        if (!offence.ticket) {
            offence.ticket = {
                id: null,
                date: '',
                time: '',
                officer: {},
                OfficerId: null,
                location: '',
                points: '',
                fine: '',
                notes: ''
            };
        }
        if (!offence.charges) {
            offence.charges = [];
        }
        return offence;
    });
};

const store = new Vuex.Store({
    state: {
        resourceConfig: {},
        visible: false,
        terminalVisible: false,
        terminalDragging: false,
        callVisible: false,
        connectionActive: false,
        panicActive: false,
        steamId: '',
        activeMarker: -1,
        activeRoute: -1,
        character: {},
        users: [],
        calls: [],
        units: [],
        unitStates: [],
        userUnits: [],
        userRanks: [],
        citizenMarkers: [],
        vehicleMarkers: [],
        charges: [],
        locations: [],
        callGrades: [],
        callTypes: [],
        callIncidents: [],
        vehicleModels: [],
        citizenSearchResults: [],
        vehicleSearchResults: [],
        modals: modalsInit
    },
    getters: {
        getResourceConfig: state => state.resourceConfig,
        getUnits: state => state.units,
        getUnitStates: state => state.unitStates,
        getUsers: state => state.users,
        getCalls: state => state.calls,
        getCitizenMarkers: state => state.citizenMarkers,
        getVehicleMarkers: state => state.vehicleMarkers,
        getCharges: state => state.charges,
        getLocations: state => state.locations,
        getCallGrades: state => state.callGrades,
        getCallTypes: state => state.callTypes,
        getCallIncidents: state => state.callIncidents,
        getVehicleModels: state => state.vehicleModels,
        getUserUnits: state => state.userUnits,
        getUserRanks: state =>
            state.userRanks.sort((a, b) => a.position - b.position),
        getRank: (state, getters) => rankId => {
            const rank = getters.getUserRanks.find(r => r.id === rankId);
            return rank ? rank.name : null;
        },
        getSteamId: state => state.steamId,
        getCitizenSearchResults: state => state.citizenSearchResults,
        getVehicleSearchResults: state => state.vehicleSearchResults,
        isVisible: state => state.visible,
        isTerminalVisible: state => state.terminalVisible,
        isTerminalDragging: state => state.terminalDragging,
        isCallVisible: state => state.callVisible,
        getUser: state => {
            return state.users.find(user => user.steamId == state.steamId);
        },
        getActiveOfficer: (state, getters) => {
            const user = getters.getUser;
            return user &&
                user.hasOwnProperty('character') &&
                user.character.__typename == 'Officer'
                ? user.character
                : null;
        },
        userUnitStatus: (state, getters) => unitId => {
            const user = getters.getUser;
            const userUnits = getters.getUserUnits;
            return user && userUnits
                ? userUnits.find(
                      uu => uu.UserId === user.id && uu.UnitId === unitId
                  )
                : [];
        },
        getConnectionActive: state => state.connectionActive,
        getPanicActive: state => state.panicActive,
        getIsModalOpen: state => type => state.modals[type].open,
        getModalData: state => type => state.modals[type],
        getActiveMarker: state => state.activeMarker,
        getActiveRoute: state => state.activeRoute
    },
    mutations: {
        setResourceConfig: (state, passedConfig) =>
            (state.resourceConfig = passedConfig),
        setVisible: state => (state.visible = true),
        setTerminalVisible: (state, newState) =>
            (state.terminalVisible = newState),
        setTerminalDragging: (state, newState) =>
            (state.terminalDragging = newState),
        setCallVisible: (state, newState) => (state.callVisible = newState),
        setHide: state => (state.visible = false),
        setUnits: (state, units) => (state.units = units),
        setUnitStates: (state, unitStates) => (state.unitStates = unitStates),
        setUserUnits: (state, userUnits) => (state.userUnits = userUnits),
        setUserRanks: (state, userRanks) => (state.userRanks = userRanks),
        setCitizenMarkers: (state, citizenMarkers) =>
            (state.citizenMarkers = citizenMarkers),
        setVehicleMarkers: (state, vehicleMarkers) =>
            (state.vehicleMarkers = vehicleMarkers),
        setCharges: (state, charges) => (state.charges = charges),
        setLocations: (state, locations) => (state.locations = locations),
        setCallGrades: (state, callGrades) => (state.callGrades = callGrades),
        setCallTypes: (state, callTypes) => (state.callTypes = callTypes),
        setCallIncidents: (state, callIncidents) => (state.callIncidents = callIncidents),
        setVehicleModels: (state, vehicleModels) =>
            (state.vehicleModels = vehicleModels),
        setUsers: (state, users) => (state.users = users),
        setCalls: (state, calls) => (state.calls = calls),
        setSteamId: (state, steamId) => (state.steamId = steamId),
        setCitizenSearchResultsInitial: (state, searchResults) => {
            state.citizenSearchResults = searchResults.map(r => ({
                ...r,
                offences: []
            }));
        },
        purgeEmptyOffences: (state, citizen) => {
            citizen.offences = citizen.offences.filter(offence => offence.id);
        },
        setCitizen: (state, citizen) => {
            const offences = reconstructOffences(citizen.offences);
            citizen = {
                ...citizen,
                offences
            };
            state.citizenSearchResults = state.citizenSearchResults.map(r =>
                r.id === citizen.id ? citizen : r
            );
        },
        setVehicleSearchResults: (state, searchResults) =>
            (state.vehicleSearchResults = searchResults),
        updateCitizenSearchResult: (state, updated) => {
            const resultIdx = state.citizenSearchResults.findIndex(
                r => r.id === updated.entity.id
            );
            state.citizenSearchResults.splice(resultIdx, 1, {
                ...state.citizenSearchResults[resultIdx],
                markers: updated.entity.markers
            });
        },
        updateVehicleSearchResult: (state, updated) => {
            const resultIdx = state.vehicleSearchResults.findIndex(
                r => r.id === updated.entity.id
            );
            state.vehicleSearchResults.splice(resultIdx, 1, {
                ...state.vehicleSearchResults[resultIdx],
                markers: updated.entity.markers
            });
        },
        updateVehicleInCitizenSearchResult: (state, updated) => {
            state.citizenSearchResults.forEach((result, resultIdx) => {
                const vehicleIdx = result.vehicles.findIndex(
                    v => v.id === updated.entity.id
                );
                if (vehicleIdx > -1) {
                    state.citizenSearchResults[resultIdx].vehicles.splice(
                        vehicleIdx,
                        1,
                        {
                            ...result.vehicles[vehicleIdx],
                            markers: updated.entity.markers
                        }
                    );
                }
            });
        },
        updateCitizenInVehicleSearchResult: (state, updated) => {
            state.vehicleSearchResults.forEach((result, resultIdx) => {
                if (result.citizen && result.citizen.id === updated.entity.id) {
                    state.vehicleSearchResults[resultIdx].citizen = {
                        ...state.vehicleSearchResults[resultIdx].citizen,
                        markers: updated.entity.markers
                    };
                }
            });
        },
        setConnectionIsActive: state => {
            state.connectionActive = true;
            setTimeout(() => (state.connectionActive = false), 1500);
        },
        setPanic: (state, newState) => {
            state.panicActive = newState;
        },
        setCitizenOffences: (state, citizen) => {
            if (citizen.offences) {
                // The offences we've received may be incomplete as some properties
                // may be null
                const rebuilt = reconstructOffences(citizen.offences);
                const foundIndex = state.citizenSearchResults.findIndex(
                    cit => cit.id == citizen.id
                );
                const found = state.citizenSearchResults[foundIndex];
                found.offences = rebuilt;
                state.citizenSearchResults[foundIndex] = found;
            }
        },
        setModal: (state, args) =>
            (state.modals[args.type] = {
                ...state.modals[args.type],
                ...args.data
            }),
        resetModal: (state, args) =>
            (state.modals[args.type] = { open: false }),
        setActiveMarker: (state, callId) => (state.activeMarker = callId),
        setActiveRoute: (state, callId) => (state.activeRoute = callId),
        addEmptyOffence: (state, { citizenId }) => {
            const officer = state.character;
            const emptyOffence = {
                id: null,
                date: '',
                time: '',
                location: '',
                ticket: {
                    id: null,
                    date: '',
                    time: '',
                    officer: {},
                    OfficerId: officer.id,
                    location: '',
                    points: '',
                    fine: '',
                    notes: ''
                },
                arrest: {
                    id: null,
                    date: '',
                    time: '',
                    officer: {},
                    OfficerId: officer.id,
                    charges: []
                },
                charges: []
            };
            const foundIndex = state.citizenSearchResults.findIndex(
                cit => cit.id == citizenId
            );
            const found = state.citizenSearchResults[foundIndex];
            found.offences.push(emptyOffence);
            state.citizenSearchResults[foundIndex] = found;
        }
    },
    actions: {
        setPanicIsActive: (context, { call_id }) => {
            context.commit('setPanic', call_id);
            const conf = context.getters.getResourceConfig;
            setTimeout(
                () => context.commit('setPanic', false),
                conf.panic_duration * 1000
            );
        }
    },
    subscribe: (mutation, state) => {
        logger.methods.doLog(mutation.type);
        logger.methods.doLog(mutation.payload);
        logger.methods.doLog(JSON.stringify(state));
    }
});

store.watch(
    state => state.modals,
    v => {
        logger.methods.doLog('VUEX WATCHER:');
        logger.methods.doLog(JSON.stringify(v));
    }
);

export default store;
