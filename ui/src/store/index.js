import Vue from 'vue';
import Vuex from 'vuex';

import units from '../mock/units';

Vue.use(Vuex);

export default new Vuex.Store({
    state: {
        units
    },
    getters: {
        getUnits: state => state.units.data.allUnits
    },
    mutations: {}
});
