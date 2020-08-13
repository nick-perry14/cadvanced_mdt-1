<template>
    <div>
        <div v-if="units.length > 0" id="units">
            <Unit v-for="unit in units" :key="unit.id" :unit="unit" />
        </div>
        <div v-if="!units || units.length == 0">
            <div id="no-units-text">No units available</div>
        </div>
    </div>
</template>

<script>
import Unit from './Unit.vue';
export default {
    components: { Unit },
    computed: {
        units() {
            return this.$store.getters.getUnits;
        }
    }
};
</script>
