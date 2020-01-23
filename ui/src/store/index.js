import Vue from 'vue';
import Vuex from 'vuex';

Vue.use(Vuex);

const store = new Vuex.Store({
    state: {
        visible: false,
        connectionActive: false,
        steamId: '',
        character: {},
        users: [],
        calls: [],
        units: []
    },
    getters: {
        getUnits: state => state.units,
        getUsers: state => state.users,
        getCalls: state => state.calls,
        getSteamId: state => state.SteamId,
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
        getConnectionActive: state => state.connectionActive
    },
    mutations: {
        setVisible: state => (state.visible = true),
        setHide: state => (state.visible = false),
        setUnits: (state, units) => (state.units = units),
        setUsers: (state, users) => (state.users = users),
        setCalls: (state, calls) => (state.calls = calls),
        setSteamId: (state, steamId) => (state.steamId = steamId),
        setConnectionIsActive: state => {
            state.connectionActive = true;
            setTimeout(() => (state.connectionActive = false), 1500);
        }
    },
    subscribe: (mutation, state) => {
        console.log('NUI: ' + mutation.type);
        console.log('NUI: ' + mutation.payload);
        console.log('NUI: ' + JSON.stringify(state));
    }
});

store.watch(
    state => state.connectionActive,
    v => console.log('VUEX WATCHER: ' + v)
);

export default store;
