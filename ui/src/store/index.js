import Vue from 'vue';
import Vuex from 'vuex';

import units from '../mock/units';

Vue.use(Vuex);

export default new Vuex.Store({
    state: {
        visible: false,
        units
    },
    getters: {
        getUnits: state => state.units.data.allUnits,
        isVisible: state => state.visible
    },
    mutations: {
        setVisible: state => (state.visible = true),
        setHide: state => (state.visible = false)
    }
});
