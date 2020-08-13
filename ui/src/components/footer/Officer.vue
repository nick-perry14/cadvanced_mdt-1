<template>
    <div>{{ activeOfficer }}</div>
</template>

<script>
export default {
    computed: {
        activeOfficer() {
            const officer = this.$store.getters.getActiveOfficer;
            return officer
                ? 'Officer: ' + officer.firstName + ' ' + officer.lastName
                : 'No active officer';
        }
    }
};
</script>
