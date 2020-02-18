<template>
    <div id="search-results">
        <Citizen
            v-for="citizen in results"
            v-on:openCitizenResult="setOpen($event)"
            :key="citizen.id"
            :citizen="citizen"
            :open="open"
            :setOpen="setOpen"
        ></Citizen>
    </div>
</template>

<script>
import Citizen from '../../../reusable/Citizen/Citizen.vue';
export default {
    components: {
        Citizen
    },
    data: function() {
        return {
            open: '0'
        };
    },
    methods: {
        setOpen(open) {
            this.open = open;
        }
    },
    computed: {
        results() {
            return this.$store.getters.getCitizenSearchResults;
        }
    }
};
</script>

<style scoped>
#search_results {
    overflow-y: scroll;
}
</style>
