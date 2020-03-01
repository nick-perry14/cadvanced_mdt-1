import Vue from 'vue';
import VueRouter from 'vue-router';

import Home from '../components/main/Home.vue';
import Status from '../components/main/status/Status.vue';
import SearchCitizens from '../components/main/search/citizens/SearchCitizens.vue';

Vue.use(VueRouter);

const routes = [
    {
        path: '/',
        components: {
            status: Home
        }
    },
    {
        path: '/status',
        components: {
            status: Status
        }
    },
    {
        path: '/search/citizens',
        components: {
            search: SearchCitizens
        }
    },
    {
        path: '/search/vehicles',
        components: {
            search: SearchCitizens
        }
    },
    {
        path: '/search/incidents',
        components: {
            search: SearchCitizens
        }
    },
    {
        path: '/search/bolo',
        components: {
            search: SearchCitizens
        }
    }
];

const router = new VueRouter({
    base: process.env.BASE_URL,
    routes
});

export default router;
