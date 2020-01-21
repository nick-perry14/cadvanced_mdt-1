import Vue from 'vue';
import Vuex from 'vuex';


Vue.use(Vuex);

export default new Vuex.Store({
    state: {
        visible: false,
        users: [],
        calls: [],
        units: [],
    },
    getters: {
        getUnits: state => state.units,
        isVisible: state => state.visible
    },
    mutations: {
        setVisible: state => (state.visible = true),
        setHide: state => (state.visible = false),
        setUnits: (state, units) => (state.units = units)
    }
});
