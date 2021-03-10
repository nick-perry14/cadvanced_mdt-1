<template>
    <div
        id="call"
    >
        <CallHeader
            @toggled="toggle"
            :call="call"
            :isOpen="isOpen"
        />
        <div
            v-show="isOpen"
            class="details-container"
        >
            <div class="call-grade">
                {{ call.callGrade.name }} - {{ call.callType.name }}
            </div>
            <div class="caller-info">
                {{ call.callerInfo }}
            </div>
            <div class="description" :key="description.id" v-for="description in call.callDescriptions">
                {{description.text}}
            </div>
            <div class="assignment-heading">Unit assignments:</div>
            <div class="assignments">
                <div v-for="unit in units" :key="unit.id">
                    <div class="unit-assign">
                        <input
                            :checked="isAssigned(unit.id)"
                            type="checkbox"
                            @click="toggleAssign(unit.id)"
                        />
                        {{unit.callSign}}
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import CallHeader from './CallHeader.vue';
import clientSender from '../../../../../mixins/clientSender';
export default {
    props: {
        call: {
            type: Object,
            required: true
        },
        isOpen: {
            type: Boolean,
            required: true
        }
    },
    mixins: [clientSender],
    components: {
        CallHeader
    },
    computed: {
        units() {
            const allUnits = this.$store.getters.getUnits;
            return allUnits.filter(unit => unit.unitState.active === true);
        }
    },
    methods: {
        toggle() {
            this.$emit('callToggle');
        },
        isAssigned(unitId) {
            return this.call.assignedUnits.some(au => au.id === unitId);
        },
        toggleAssign(unitId) {
            this.sendClientMessage('toggleAssignment', {
                callId: this.call.id,
                unitId,
                currentlyAssigned: this.isAssigned(unitId)
            });
        }
    }
};
</script>

<style scoped>
#call {
    display: flex;
    flex-direction: column;
    border: 3px solid rgba(255, 255, 255, 0.5);
    box-sizing: border-box;
    border-radius: 10px;
}
#call:first-child {
    margin-left: 0;
}
#call:last-child {
    margin-right: 0;
}
.details-container {
    display: flex;
    flex-direction: column;
    height: 100%;
    overflow-y: auto;
    padding: 0 20px;
    color: rgba(255,255,255,0.7);
}
.details-container > div {
    margin-bottom: 10px;
}
.caller-info {
    font-weight: bold;
}
.call-grade {
    font-size: 20px;
    text-transform: uppercase;
    font-weight: bold;
    margin-bottom: 15px;
}
.assignment-heading {
    margin: 10px 0;
}
.unit-assign {
    display: flex;
}
.unit-assign input {
    margin-right: 10px;
}
</style>