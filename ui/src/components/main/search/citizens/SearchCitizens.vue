<template>
    <div>
        <SearchBar v-on:searchChanged="sendSearch($event)" />
        <SearchResults />
    </div>
</template>

<script>
import SearchBar from './SearchBar.vue';
import SearchResults from './SearchResults.vue';
import clientSender from '../../../../mixins/clientSender';
export default {
    components: {
        SearchBar,
        SearchResults
    },
    mixins: [clientSender],
    methods: {
        sendSearch(sendObject) {
            this.sendClientMessage('searchCitizen', sendObject);
        }
    },
    destroyed: function() {
        this.$store.commit(
            'setCitizenSearchResults',
            []
        );
    }
};
</script>
