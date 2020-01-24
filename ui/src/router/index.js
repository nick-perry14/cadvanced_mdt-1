import Vue from 'vue';
import VueRouter from 'vue-router';

import Status from '../components/main/status/Status.vue';
import Search from '../components/main/search/Search.vue';

Vue.use(VueRouter);

const routes = [
    {
        path: '/status',
        components: {
            status: Status
        }
    },
    {
        path: '/search/citizens',
        components: {
            search: Search
        }
    },
    {
        path: '/search/vehicles',
        components: {
            search: Search
        }
    },
    {
        path: '/search/incidents',
        components: {
            search: Search
        }
    },
    {
        path: '/search/bolo',
        components: {
            search: Search
        }
    }
];

const router = new VueRouter({
    base: process.env.BASE_URL,
    routes
});

export default router;
