import Vue from 'vue';
import Vuex from 'vuex';

Vue.use(Vuex);

export default new Vuex.Store({
    state: {
        visible: false,
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
        isVisible: state => state.visible
    },
    mutations: {
        setVisible: state => (state.visible = true),
        setHide: state => (state.visible = false),
        setUnits: (state, units) => (state.units = units),
        setUsers: (state, users) => (state.users = users),
        setCalls: (state, calls) => (state.calls = calls),
        setSteamId: (state, steamId) => (state.steamId = steamId)
    }
});
