<template>
    <Modal id="unit-modal" :open="isOpen" @close="close">
        <template v-slot:header>
            {{unit.id ? ('Edit') : ('Create')}} unit
        </template>
        <template v-slot:body>
            <div v-if="failedValidation" class="failed-validation">
                All fields must be completed
            </div>
            <div class="unit">
                <div id="unit-callsign">
                    <input
                        type="text"
                        v-model="unit.callSign"
                        placeholder="Unit callsign"
                    />
                </div>
                <div id="type-state">
                    <div id="unit-type">
                        <v-select
                            class="unit-select"
                            v-model="unit.unitType"
                            label="name"
                            :options="$store.getters.getUnitTypes"
                        />
                    </div>
                    <div id="unit-state">
                        <v-select
                            class="unit-select"
                            v-model="unit.unitState"
                            label="name"
                            :options="$store.getters.getUnitStates"
                        />
                    </div>
                </div>
            </div>
        </template>
        <template v-slot:footer>
            <MiniButton
                @miniClick="saveUnit"
                class="unit-save-button"
                text="Save"
                colour="rgba(0,255,0,0.5)"
            />
        </template>
    </Modal>
</template>

<script>
import Modal from '../Modal.vue';
import clientSender from '../../../mixins/clientSender';
import MiniButton from '../../MiniButton.vue';
export default {
    data: function() {
        return {
            unit: JSON.parse(JSON.stringify(this.$store.getters.getModalData('unit').entity)),
            failedValidation: false
        }
    },
    components: {
        Modal,
        MiniButton
    },
    mixins: [clientSender],
    computed: {
        isOpen() {
            return this.$store.getters.getIsModalOpen('unit');
        }
    },
    methods: {
        close() {
            this.$store.commit('resetModal', {
                type: 'unit'
            });
        },
        saveUnit() {
            // First check we've got everything
            if (
                this.unit.callSign.length === 0 ||
                !this.unit.unitType.id ||
                !this.unit.unitState.id
            ) {
                this.failedValidation = true;
            } else {
                this.failedValidation = false;
                this.sendClientMessage('sendUnit', this.unit);
                this.$store.commit('resetModal', {
                    type: 'unit'
                });
            }
        }
    }
};
</script>

<style scoped>
.unit {
    display: flex;
    flex-direction: column;
}
#unit-callsign {
    display: flex;
}
#unit-callsign input {
    flex: 1;
}
#type-state {
    margin-top: 10px;
    display: flex;
}
#unit-type {
    flex: 1;
    padding-right: 10px;
}
#unit-state {
    flex: 1;
    padding-left: 10px;
}
input {
    flex: 1;
    padding: 10px;
    border: 0;
    outline: 0;
    background: rgba(255, 255, 255, 0.1);
    color: rgba(255, 255, 255, 0.5);
    font-size: 14px;
}
.unit-select >>> .vs__dropdown-toggle {
    height: 44px;
    border-radius: 5px;
    border: 2px solid rgba(255, 255, 255, 0.5);
    background: none;
    color: rgba(255, 255, 255, 0.5);
    font-weight: 500;
    font-size: 14px;
    letter-spacing: 0.12em;
}
.unit-select >>> .vs__dropdown-menu {
    background: #4a4a4a;
    border: 2px solid rgba(255, 255, 255, 0.5);
    border-top: 0;
    color: rgba(255, 255, 255, 0.5);
    font-weight: 500;
    font-size: 14px;
    letter-spacing: 0.12em;
    overflow-x: hidden;
    overflow-y: auto;
}
.unit-select >>> .vs__search,
.unit-select >>> .vs__dropdown-option {
    color: rgba(255, 255, 255, 0.5);
    overflow-x: hidden;
}
.unit-select >>> .vs__dropdown-option--highlight {
    background: rgba(0, 0, 0, 0.5);
}
.unit-select >>> .vs__selected-options {
    overflow-x: hidden;
    overflow-y: hidden;
    white-space: nowrap;
}
.unit-select >>> .vs__selected {
    color: rgba(255, 255, 255, 0.5);
}
.unit-select >>> .vs__clear {
    display: none;
}
.unit-select >>> .vs__open-indicator {
    fill: rgba(255, 255, 255, 0.5);
    margin-right: 10px;
}
</style>
