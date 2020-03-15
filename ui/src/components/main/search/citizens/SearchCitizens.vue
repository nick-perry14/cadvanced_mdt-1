<template>
    <div>
        <SearchBar v-on:searchChanged="sendSearch($event)" />
        <UpdateMessage v-if="isLoading" message="Contacting control..." />
        <SearchResults v-else />
    </div>
</template>

<script>
    import UpdateMessage from '../../../reusable/UpdateMessage.vue';
    import SearchBar from './SearchBar.vue';
    import SearchResults from './SearchResults.vue';
    import clientSender from '../../../../mixins/clientSender';
    export default {
        components: {
            SearchBar,
            SearchResults,
            UpdateMessage
        },
        data: function() {
            return {
                isLoading: false
            };
        },
        mixins: [clientSender],
        methods: {
            sendSearch(sendObject) {
                this.isLoading = true;
                this.sendClientMessage('searchCitizen', sendObject);
            }
        },
        watch: {
            results: function() {
                this.isLoading = false;
            }
        },
        computed: {
            results() {
                return this.$store.getters.getCitizenSearchResults;
            }
        },
        destroyed: function() {
            this.$store.commit('setCitizenSearchResults', []);
        }
    };
</script>
