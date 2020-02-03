<template>
    <div>
        <SearchBar />
        <SearchResults />
    </div>
</template>

<script>
import SearchBar from './SearchBar.vue';
import SearchResults from './SearchResults.vue';
export default {
    components: {
        SearchBar,
        SearchResults
    }
};
</script>
