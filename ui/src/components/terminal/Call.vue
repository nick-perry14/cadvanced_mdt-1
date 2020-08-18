<template>
    <div class="call-details">
        <div>
            {{ incidentString }}
        </div>
        <div>{{ call.callGrade.name }}</div>
        <div>{{ locationsString }}</div>
        <div class="call-descriptions">
            <div
                class="call-description"
                v-for="description in descriptions"
                :key="description.id"
                :description="description"
            >
                {{ description }}
            </div>
        </div>
    </div>
</template>

<script>
export default {
    props: {
        call: {
            type: Object,
            required: true
        }
    },
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
    },
    watch: {
        incidentString: function() {
            this.$emit('changed');
        },
        locationsString: function() {
            this.$emit('changed');
        }
    }
};
</script>

<style scoped>
.call-details {
    padding: 20px 0;
    margin-bottom: 14px;
    font-size: 14px;
    text-transform: uppercase;
    line-height: 16px;
    letter-spacing: 0.1em;
    color: rgba(255, 255, 255, 0.7);
}
.call-descriptions {
    margin-top: 20px;
    font-weight: normal;
    text-transform: none;
}
div:last-child {
    margin-bottom: 0;
}
div.marker-icon {
    cursor: pointer;
    font-size: 20px;
    margin: 10px 0 10px 10px;
    float: right;
}
</style>
