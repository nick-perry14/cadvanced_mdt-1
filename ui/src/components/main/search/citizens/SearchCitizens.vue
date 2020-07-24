<template>
    <div>
        <OffenceModal v-if="offenceModalOpen" />
        <MarkersModal v-if="markersModalOpen" />
        <SearchBar v-on:searchChanged="sendSearch($event)" />
        <UpdateMessage v-if="isLoading" message="Contacting control..." />
        <SearchResults v-else :searched="searched" />
    </div>
</template>

<script>
import UpdateMessage from '../../../reusable/UpdateMessage.vue';
import SearchBar from './SearchBar.vue';
import SearchResults from './SearchResults.vue';
import MarkersModal from '../../../reusable/Citizen/MarkersModal/MarkersModal.vue';
import OffenceModal from '../../../reusable/Offence/OffenceModal.vue';
import clientSender from '../../../../mixins/clientSender';
export default {
    components: {
        SearchBar,
        SearchResults,
        UpdateMessage,
        MarkersModal,
        OffenceModal
    },
    data: function() {
        return {
            searched: false,
            isLoading: false
        };
    },
    mixins: [clientSender],
    computed: {
        results() {
            return this.$store.getters.getCitizenSearchResults;
        },
        offenceModalOpen() {
            return this.$store.getters.getIsModalOpen('offence');
        },
        markersModalOpen() {
            return this.$store.getters.getIsModalOpen('markers');
        }
    },
    methods: {
        sendSearch(sendObject) {
            this.isLoading = true;
            this.searched = true;
            this.sendClientMessage('searchCitizen', sendObject);
        },
        purgeEmpty() {
            this.results;
        }
    },
    watch: {
        results: function() {
            this.isLoading = false;
        }
    },
    destroyed: function() {
        this.$store.commit('setCitizenSearchResultsInitial', []);
    }
};
</script>
