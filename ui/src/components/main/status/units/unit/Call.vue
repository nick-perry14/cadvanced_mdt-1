<template>
    <div class="call-details">
        <div>{{ incidentString }}</div>
        <div>{{ locationsString }}</div>
    </div>
</template>

<script>
export default {
    props: ['call'],
    computed: {
        incidentString() {
            return this.call.callIncidents.map(curr => curr.name).join(', ');
        },
        locationsString() {
            return this.call.callLocations.map(curr => curr.name).join(', ');
        }
    }
};
</script>

<style scoped>
.call-details {
    padding: 20px 8px;
    background: rgba(255, 255, 255, 0.1);
    margin-bottom: 10px;
    font-size: 14px;
    line-height: 16px;
    color: rgba(255, 255, 255, 0.7);
}
div:last-child {
    margin-bottom: 0;
}
</style>