<template>
    <Modal :open="isOpen" @close="close">
        <template v-slot:header>
            {{call.id ? ('Edit') : ('Create')}} call
        </template>
        <template v-slot:body>
            <div v-if="failedValidation" class="failed-validation">
                All fields must be completed
            </div>
            <div class="call">
                <div class="callerInfo">
                    <input
                        type="text"
                        v-model="call.callerInfo"
                        placeholder="Caller information"
                    />
                </div>
                <div class="gradeType">
                    <div class="grade">
                        <v-select
                            class="call-select"
                            v-model="call.callGrade"
                            label="name"
                            :options="$store.getters.getCallGrades"
                        />
                    </div>
                    <div class="type">
                        <v-select
                            class="call-select"
                            v-model="call.callType"
                            label="name"
                            :options="$store.getters.getCallTypes"
                        />
                    </div>
                </div>
                <div class="descriptions">
                    <div
                        v-for="(description, index) in call.callDescriptions"
                        :key="description.id"
                        class="description">
                            <input
                                type="text"
                                v-model="call.callDescriptions[index].text"
                                placeholder="Description"
                            />
                            <MiniButton
                                @miniClick="deleteDescription(index)"
                                class="description-button"
                                icon="fa-trash-alt"
                                colour="rgba(255,0,0,0.5)"
                            />
                    </div>
                    <div class="description">
                        <input
                            type="text"
                            v-model="newDescription"
                            placeholder="Description"
                        />
                        <MiniButton
                            @miniClick="saveDescription"
                            class="description-button"
                            icon="fa-save"
                            colour="rgba(0,255,0,0.5)"
                        />
                    </div>
                </div>
                <div class="incidents">
                    <vue-tags-input
                        v-model="incidentTag"
                        :tags="thingToTags(call.callIncidents)"
                        :add-only-from-autocomplete="true"
                        :placeholder="'Add incidents'"
                        :autocomplete-items="filteredItemsIncidents"
                        @tags-changed="
                            newIncidents =>
                                (call.callIncidents = tagsToThing(
                                    newIncidents
                                ))
                        "
                    />
                </div>
                <div class="locations">
                    <vue-tags-input
                        v-model="locationTag"
                        :tags="thingToTags(call.callLocations)"
                        :add-only-from-autocomplete="true"
                        :placeholder="'Add locations'"
                        :autocomplete-items="filteredItemsLocations"
                        @tags-changed="
                            newLocations =>
                                (call.callLocations = tagsToThing(
                                    newLocations
                                ))
                        "
                    />
                </div>
            </div>
        </template>
        <template v-slot:footer>
            <MiniButton
                @miniClick="saveCall"
                class="call-save-button"
                text="Save"
                colour="rgba(0,255,0,0.5)"
            />
        </template>
    </Modal>
</template>

<script>
import VueTagsInput from '@johmun/vue-tags-input';
import Modal from '../Modal.vue';
import MiniButton from '../../MiniButton.vue';
import clientSender from '../../../mixins/clientSender';
export default {
    data: function() {
        return {
            call: JSON.parse(JSON.stringify(this.$store.getters.getModalData('call').entity)),
            newDescription: '',
            incidentTag: '',
            locationTag: '',
            failedValidation: false
        }
    },
    components: {
        Modal,
        MiniButton,
        VueTagsInput
    },
    mixins: [clientSender],
    computed: {
        isOpen() {
            return this.$store.getters.getIsModalOpen('call');
        },
        filteredItemsIncidents() {
            const incidents = this.$store.getters.getCallIncidents;
            const filtered = incidents.filter(i => {
                return (
                    i.name
                        .toLowerCase()
                        .indexOf(this.incidentTag.toLowerCase()) !== -1
                );
            });
            return this.thingToTags(filtered);
        },
        filteredItemsLocations() {
            const locations = this.$store.getters.getLocations;
            const filtered = locations.filter(i => {
                return (
                    i.name
                        .toLowerCase()
                        .indexOf(this.locationTag.toLowerCase()) !== -1
                );
            });
            return this.thingToTags(filtered);
        }
    },
    methods: {
        close() {
            this.$store.commit('resetModal', {
                type: 'call'
            });
        },
        saveDescription() {
            if (this.newDescription.length > 0) {
                const now = Date.now();
                this.call.callDescriptions.push({
                    id: Math.floor(Math.random() * 50000 + 1),
                    text: this.newDescription
                });
                this.newDescription = '';
            }
        },
        deleteDescription(index) {
            this.call.callDescriptions.splice(index, 1);
        },
        thingToTags(input) {
            return input.map(({ id, name }) => ({ id, text: name }))
        },
        tagsToThing(input) {
            return input.map(({ id, text }) => ({ id, name: text }));
        },
        saveCall() {
            // First check we have everything we need
            if (
                !this.call.callGrade.id ||
                !this.call.callType.id ||
                this.call.callerInfo.length === 0 ||
                this.call.callIncidents.length === 0 ||
                this.call.callLocations.length === 0 ||
                this.call.callDescriptions.length === 0
            ) {
                this.failedValidation = true;
            } else {
                this.failedValidation = false;
                this.sendClientMessage('sendCall', this.call);
                this.$store.commit('resetModal', {
                    type: 'call'
                });
            }
        }
    }
};
</script>

<style scoped>
.call {
    display: flex;
    flex-direction: column;
}
.call > div:not(:last-child) {
    margin-bottom: 20px;
}
.callerInfo {
    display: flex;
}
.gradeType {
    display: flex;
}
.grade, .type {
    flex: 1;
}
.gradeType > div {
    margin: 0 5px;
}
.gradeType > div:first-child {
    margin-left: 0;
}
.gradeType > div:last-child {
    margin-right: 0;
}
.descriptions {
    display: flex;
    flex-direction: column;
    max-height: 200px;
    overflow-y: auto;
    padding-right: 10px;
}
.description {
    display: flex;
}
.description:not(:last-child) {
    margin-bottom: 10px;
}
.description-button,
.call-save-button {
    margin-left: 10px;
}
.call-select >>> .vs__dropdown-toggle {
    height: 44px;
    border-radius: 5px;
    border: 2px solid rgba(255, 255, 255, 0.5);
    background: none;
    color: rgba(255, 255, 255, 0.5);
    font-weight: 500;
    font-size: 14px;
    letter-spacing: 0.12em;
}
.call-select >>> .vs__dropdown-menu {
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
.call-select >>> .vs__search,
.call-select >>> .vs__dropdown-option {
    color: rgba(255, 255, 255, 0.5);
    overflow-x: hidden;
}
.call-select >>> .vs__dropdown-option--highlight {
    background: rgba(0, 0, 0, 0.5);
}
.call-select >>> .vs__selected-options {
    overflow-x: hidden;
    overflow-y: hidden;
    white-space: nowrap;
}
.call-select >>> .vs__selected {
    color: rgba(255, 255, 255, 0.5);
}
.call-select >>> .vs__clear {
    display: none;
}
.call-select >>> .vs__open-indicator {
    fill: rgba(255, 255, 255, 0.5);
    margin-right: 10px;
}
.failed-validation {
    margin: 10px 0;
    background: rgba(255, 0, 0, 0.5);
    color: rgba(255,255,255,0.9);
    padding: 10px;
    text-align: center;
}
input,
textarea {
    flex: 1;
    padding: 10px;
    border: 0;
    outline: 0;
    background: rgba(255, 255, 255, 0.1);
    color: rgba(255, 255, 255, 0.5);
    font-size: 14px;
}
.vue-tags-input {
    max-width: 100% !important;
    background-color: rgba(255, 255, 255, 0.1) !important;
}
.vue-tags-input .ti-tag {
    background: #333;
}
.vue-tags-input .ti-new-tag-input {
    background-color: transparent !important;
    color: #fff !important;
}
.vue-tags-input .ti-input {
    padding: 4px 10px;
}
.vue-tags-input .ti-autocomplete {
    background: #4a4a4a;
    border: 1px solid rgba(255, 255, 255, 0.3);
    color: #fff;
}
.vue-tags-input .ti-autocomplete .ti-selected-item {
    background: #333;
}
.vue-tags-input .ti-deletion-mark {
    background: rgba(255, 0, 0, 0.5) !important;
}
</style>
