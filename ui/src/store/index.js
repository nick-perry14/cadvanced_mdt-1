import Vue from 'vue';
import Vuex from 'vuex';

Vue.use(Vuex);

const store = new Vuex.Store({
    state: {
        visible: false,
        connectionActive: false,
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
        citizenSearchResults: [],
        modalsOpen: {
            ranks: false,
            unitStates: false
        }
    },
    getters: {
        getUnits: state => state.units,
        getUnitStates: state => state.unitStates,
        getUsers: state => state.users,
        getCalls: state => state.calls,
        getUserUnits: state => state.userUnits,
        getUserRanks: state =>
            state.userRanks.sort((a, b) => a.position - b.position),
        getRank: (state, getters) => rankId => {
            const rank = getters.getUserRanks.find(r => r.id === rankId);
            return rank ? rank.name : null;
        },
        getSteamId: state => state.steamId,
        getCitizenSearchResults: state => state.citizenSearchResults,
        isVisible: state => state.visible,
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
        getConnectionActive: state => state.connectionActive,
        getIsModalOpen: state => type => state.modalsOpen[type],
        getActiveMarker: state => state.activeMarker,
        getActiveRoute: state => state.activeRoute
    },
    mutations: {
        setVisible: state => (state.visible = true),
        setHide: state => (state.visible = false),
        setUnits: (state, units) => (state.units = units),
        setUnitStates: (state, unitStates) => (state.unitStates = unitStates),
        setUserUnits: (state, userUnits) => (state.userUnits = userUnits),
        setUserRanks: (state, userRanks) => (state.userRanks = userRanks),
        setUsers: (state, users) => (state.users = users),
        setCalls: (state, calls) => (state.calls = calls),
        setSteamId: (state, steamId) => (state.steamId = steamId),
        setCitizenSearchResults: (state, searchResults) => {
            state.citizenSearchResults = searchResults.map(r => ({
                ...r,
                offences: []
            }));
        },
        setConnectionIsActive: state => {
            state.connectionActive = true;
            setTimeout(() => (state.connectionActive = false), 1500);
        },
        setCitizenOffences: (state, citizen) => {
            if (citizen.offences.length > 0) {
                const foundIndex = state.citizenSearchResults.findIndex(
                    cit => cit.id == citizen.id
                );
                const found = state.citizenSearchResults[foundIndex];
                found.offences = citizen.offences;
                state.citizenSearchResults[foundIndex] = found;
            }
        },
        setModalOpen: (state, args) =>
            (state.modalsOpen[args.type] = args.status),
        setActiveMarker: (state, callId) => (state.activeMarker = callId),
        setActiveRoute: (state, callId) => (state.activeRoute = callId)
    },
    subscribe: (mutation, state) => {
        console.log('NUI: ' + mutation.type);
        console.log('NUI: ' + mutation.payload);
        console.log('NUI: ' + JSON.stringify(state));
    }
});

store.watch(
    state => state.userRanks,
    v => {
        console.log('VUEX WATCHER:');
        console.log(JSON.stringify(v));
    }
);

export default store;
