<template>
    <div id="units">
        <Unit v-for="unit in units" :key="unit.id" :unit="unit"></Unit>
    </div>
</template>

<script>
import Unit from './unit/Unit.vue';
export default {
    components: {
        Unit
    },
    computed: {
        units() {
            return this.$store.getters.getUnits;
        }
    }
};
</script>

<style scoped>
#units {
    display: flex;
    align-items: stretch;
}
</style>
