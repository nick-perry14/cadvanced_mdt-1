<template>
    <div class="call-details">
        <div>{{ incidentString }}</div>
        <div>{{ locationsString }}</div>
        <div class="call-descriptions">
            <div class="call-description" v-for="description in descriptions" v-bind:key="description.id" v-bind:description="description"></Unit>
                {{ description }}
            </div>
        </div>
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
        },
        descriptions() {
            return this.call.callDescriptions.map(curr => curr.text);
        }
    }
};
</script>

<style scoped>
.call-details {
    padding: 20px 8px;
    background: rgba(255, 255, 255, 0.1);
    margin-bottom: 14px;
    font-size: 14px;
    font-weight: bold;
    line-height: 16px;
    color: rgba(255, 255, 255, 0.7);
}
.call-descriptions {
    margin-top: 20px;
    font-weight: normal;
}
div:last-child {
    margin-bottom: 0;
}
</style>