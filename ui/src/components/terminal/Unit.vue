<template>
    <div
        v-if="isAssignedToUnit"
        id="unit"
        class="unit"
        :class="{ inPanic: isInPanic }"
    >
        <div
            class="unit-callsign"
            :style="{ color: '#' + unit.unitState.colour }"
        >
            {{ unit.callSign }}
        </div>
        <div class="unit-type-name">
            {{ unit.unitType.name }}
        </div>
        <div class="unit-state-name">
            {{ unit.unitState.name }}
        </div>
        <div class="calls-container">
            <Call
                v-for="(call, index) in assignedCalls"
                @changed="callChanged"
                :key="index"
                :call="call"
            />
            <div v-if="!hasCalls" class="no-calls-container">
                No assigned calls
            </div>
        </div>
    </div>
</template>

<script>
import soundPlayer from '../../mixins/soundPlayer';
import Call from './Call.vue';
export default {
    components: { Call },
    props: {
        unit: {
            type: Object,
            required: true
        }
    },
    mixins: [soundPlayer],
    computed: {
        hasCalls() {
            return this.assignedCalls.length > 0;
        },
        assignedCalls() {
            return this.$store.getters.getCalls.filter(call =>
                call.assignedUnits.some(unit => unit.id == this.unit.id)
            );
        },
        isAssignedToUnit() {
            return this.userUnitStatus ? true : false;
        },
        userUnitStatus() {
            return this.$store.getters.userUnitStatus(this.unit.id);
        },
        isInPanic() {
            return this.unit.unitState.code === 'PANIC';
        }
    },
    methods: {
        callChanged() {
            if (this.isAssignedToUnit) {
                this.playRoger();
            }
        }
    },
    watch: {
        isAssignedToUnit() {
            this.playRoger();
        },
        assignedCalls(newVal, oldVal) {
            if (this.isAssignedToUnit && newVal.length !== oldVal.length) {
                this.playRoger();
            }
        },
        'unit.unitState.id': function(newV, oldV) {
            if (this.isAssignedToUnit && newV !== oldV) {
                this.playRoger();
            }
        }
    }
};
</script>

<style scoped>
.unit {
    padding: 10px;
    background: rgba(0, 0, 0, 0.5);
    letter-spacing: 0.1em;
    margin-bottom: 5px;
}
.unit:last-child {
    margin-bottom: 0;
}
.unit.inPanic {
    border: 2px solid #e20000;
}
.unit-type-name,
.unit-state-name {
    color: rgba(255, 255, 255, 0.5);
    font-size: 10px;
    text-align: right;
}
.no-calls-container {
    padding: 20px 0;
    color: rgba(255, 255, 255, 0.5);
    text-align: center;
}
</style>
