<template>
    <div class="unit-header">
        <div class="top-row">
            <div
                class="callsign"
                :style="{ color: '#' + unit.unitState.colour }"
            >
                {{ unit.callSign }}
            </div>
        </div>
        <div class="bottom-row">
            <div class="unit-header-summary">
                <span class="unit-state-name">{{ unit.unitState.name }}</span> -
                Chief inspector
            </div>
            <div class="unit-actions">
                <MiniButton text="Status" colour="rgba(255, 255, 255, 0.3)" />
                <MiniButton text="Leave" colour="rgba(255, 0, 0, 0.5)" />
            </div>
        </div>
    </div>
</template>

<script>
import MiniButton from '../../../../MiniButton.vue';
export default {
    components: {
        MiniButton
    },
    props: {
        unit: {
            type: Object,
            required: true
        }
    }
};
</script>

<style scoped>
.unit-header {
    background: rgba(0, 0, 0, 0.1);
    padding: 20px;
    margin-bottom: 30px;
}
.top-row {
    margin-bottom: 20px;
}
.callsign {
    font-size: 30px;
    letter-spacing: 0.1em;
}
.bottom-row {
    display: flex;
    justify-content: space-between;
    align-items: top;
    font-size: 14px;
    color: rgba(255, 255, 255, 0.5);
}
.unit-header-summary {
    margin-right: 14px;
}
.unit-state-name {
    text-transform: uppercase;
}
.unit-actions {
    flex-shrink: 0;
    text-align: right;
}
</style>
