<template>
    <div id="unit">
        <UnitHeader v-bind:unit="unit" />
        <Call v-for="(call, index) in unit.assignedCalls" v-bind:key="index" v-bind:call="call" />
    </div>
</template>

<script>
import UnitHeader from './UnitHeader.vue';
import Call from './Call.vue';
export default {
    props: ['unit'],
    components: {
        UnitHeader,
        Call
    }
};
</script>

<style scoped>
#unit {
    border: 3px solid rgba(255, 255, 255, 0.5);
    box-sizing: border-box;
    border-radius: 10px;
    margin: 0 20px;
    width: 380px;
}
#unit:first-child {
    margin-left: 0;
}
#unit:last-child {
    margin-right: 0;
}
</style>