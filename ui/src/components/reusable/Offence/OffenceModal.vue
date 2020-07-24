<template>
    <Modal @close="close" :open="isOpen">
        <template v-slot:header>
            Offence
        </template>
        <template v-slot:body>
            <div class="offence">
                <div class="meta">
                    <input
                        type="text"
                        v-model="offence.date"
                        placeholder="Enter date"
                    />
                    <input
                        type="text"
                        v-model="offence.time"
                        placeholder="Enter time"
                    />
                    <input
                        type="text"
                        v-model="offence.location"
                        placeholder="Location"
                    />
                </div>
                <div v-if="!offence.id" class="continue">
                    <MiniButton
                        @miniClick="sendMeta()"
                        text="Continue..."
                        colour="rgba(0,255,0,0.5)"
                        borderRadius="3px"
                        icon="fa-save"
                        padding="6px 8px"
                    />
                </div>
                <div v-if="offence.id" class="continue">
                    <MiniButton
                        @miniClick="sendMeta()"
                        colour="rgba(0,255,0,0.5)"
                        borderRadius="3px"
                        icon="fa-save"
                        padding="6px 8px"
                    />
                </div>
                <div v-if="offence.id" class="operations">
                    <div class="tablist">
                        <button
                            @click="setActiveTab(1)"
                            role="tab"
                            class="tab"
                            :class="{ selected: active === 1 }"
                        >
                            Arrest
                        </button>
                        <button
                            @click="setActiveTab(2)"
                            role="tab"
                            class="tab"
                            :class="{ selected: active === 2 }"
                        >
                            Charges
                        </button>
                        <button
                            @click="setActiveTab(3)"
                            role="tab"
                            class="tab"
                            :class="{ selected: active === 3 }"
                        >
                            Ticket
                        </button>
                    </div>
                    <div class="content">
                        <div class="arrest-container" v-show="active === 1">
                            <div class="meta">
                                <input
                                    type="text"
                                    v-model="offence.arrest.date"
                                    placeholder="Enter arrest date"
                                />
                                <input
                                    type="text"
                                    v-model="offence.arrest.time"
                                    placeholder="Enter arrest time"
                                />
                            </div>
                            <div class="arrest-content">
                                <div class="arrest-input">
                                    <vue-tags-input
                                        v-model="arrestTag"
                                        :tags="
                                            offenceToTags(
                                                offence.arrest.charges
                                            )
                                        "
                                        :add-only-from-autocomplete="true"
                                        :placeholder="'Add arrest charges'"
                                        :autocomplete-items="
                                            filteredItemsArrest
                                        "
                                        @tags-changed="
                                            newCharges =>
                                                (offence.arrest.charges = tagsToOffence(
                                                    newCharges
                                                ))
                                        "
                                    />
                                </div>
                            </div>
                            <div class="actionlist">
                                <MiniButton
                                    @miniClick="saveArrest()"
                                    text="Send to control"
                                    colour="rgba(0,255,0,0.5)"
                                    borderRadius="3px"
                                    icon="fa-save"
                                    padding="6px 8px"
                                />
                            </div>
                        </div>
                        <div class="charges-container" v-show="active === 2">
                            <div class="charges-content">
                                <vue-tags-input
                                    v-model="chargesTag"
                                    :tags="offenceToTags(offence.charges)"
                                    :add-only-from-autocomplete="true"
                                    :placeholder="'Add charges'"
                                    :autocomplete-items="filteredItemsCharges"
                                    @tags-changed="
                                        newCharges =>
                                            (offence.charges = tagsToOffence(
                                                newCharges
                                            ))
                                    "
                                />
                            </div>
                            <div class="actionlist">
                                <MiniButton
                                    @miniClick="saveCharges()"
                                    text="Send to control"
                                    colour="rgba(0,255,0,0.5)"
                                    borderRadius="3px"
                                    icon="fa-save"
                                    padding="6px 8px"
                                />
                            </div>
                        </div>
                        <div class="tickets" v-show="active === 3">
                            <div class="meta">
                                <input
                                    type="text"
                                    v-model="offence.ticket.date"
                                    placeholder="Enter ticket date"
                                />
                                <input
                                    type="text"
                                    v-model="offence.ticket.time"
                                    placeholder="Enter ticket time"
                                />
                                <input
                                    type="text"
                                    v-model="offence.ticket.location"
                                    placeholder="Enter ticket location"
                                />
                            </div>
                            <div class="ticket-content">
                                <div class="ticket-input">
                                    <input
                                        type="text"
                                        placeholder="Points"
                                        v-model="offence.ticket.points"
                                    />
                                </div>
                                <div class="ticket-input">
                                    <input
                                        type="text"
                                        placeholder="Fine"
                                        v-model="offence.ticket.fine"
                                    />
                                </div>
                                <div class="ticket-input notes">
                                    <textarea
                                        placeholder="Notes"
                                        v-model="offence.ticket.notes"
                                    ></textarea>
                                </div>
                            </div>
                            <div class="actionlist">
                                <MiniButton
                                    @miniClick="saveTicket()"
                                    text="Send to control"
                                    colour="rgba(0,255,0,0.5)"
                                    borderRadius="3px"
                                    icon="fa-save"
                                    padding="6px 8px"
                                />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </template>
    </Modal>
</template>

<script>
import VueTagsInput from '@johmun/vue-tags-input';
import Modal from '../Modal.vue';
import MiniButton from '../../MiniButton.vue';
import clientSender from '../../../mixins/clientSender';
export default {
    props: {
        searchResults: {
            type: Array,
            required: true
        }
    },
    data: function() {
        return {
            activeTab: 1,
            arrestTag: '',
            chargesTag: '',
            arrestCharges: []
        };
    },
    mixins: [clientSender],
    components: {
        VueTagsInput,
        Modal,
        MiniButton
    },
    computed: {
        isOpen() {
            return this.$store.getters.getIsModalOpen('offence');
        },
        active() {
            return this.activeTab;
        },
        offence() {
            const modalData = this.$store.getters.getModalData('offence');
            return modalData.entity
                ? modalData.entity.offences[modalData.offenceIndex]
                : {};
        },
        filteredItemsArrest() {
            const charges = this.$store.getters.getCharges;
            const filtered = charges.filter(i => {
                return (
                    i.name
                        .toLowerCase()
                        .indexOf(this.arrestTag.toLowerCase()) !== -1
                );
            });
            return this.offenceToTags(filtered);
        },
        filteredItemsCharges() {
            const charges = this.$store.getters.getCharges;
            const filtered = charges.filter(i => {
                return (
                    i.name
                        .toLowerCase()
                        .indexOf(this.chargesTag.toLowerCase()) !== -1
                );
            });
            return this.offenceToTags(filtered);
        }
    },
    methods: {
        setActiveTab(id) {
            this.activeTab = id;
        },
        close() {
            const modalData = this.$store.getters.getModalData('offence');
            this.$store.commit('purgeEmptyOffences', modalData.entity);
            this.$store.commit('resetModal', {
                type: 'offence'
            });
        },
        sendMeta() {
            // Create a new offence's metadata
            // This is the same operation as saveCharges except we don't pass an ID
            const modalData = this.$store.getters.getModalData('offence');
            const sendObj = {
                CitizenId: modalData.entity.id,
                date: this.offence.date,
                location: this.offence.location,
                time: this.offence.time,
                charges: this.offence.charges
            };
            if (this.offence.id) {
                sendObj.id = this.offence.id;
            }
            this.sendClientMessage('sendOffenceMeta', sendObj);
        },
        saveArrest() {
            const modalData = this.$store.getters.getModalData('offence');
            const officer = this.$store.getters.getActiveOfficer;
            const sendObj = {
                CitizenId: modalData.entity.id,
                date: this.offence.arrest.date,
                time: this.offence.arrest.time,
                location: this.offence.location,
                OffenceId: this.offence.id,
                OfficerId: officer.id,
                charges: this.offence.arrest.charges
            };
            if (this.offence.arrest.id) {
                sendObj.id = this.offence.arrest.id;
            }
            this.sendClientMessage('saveArrest', sendObj);
            // Update the search result so it displays the new arrest
            this.$store.commit(modalData.updateMutation, {
                entity: this.$store.getters.getModalData('offence').entity
            });
        },
        saveCharges() {
            // This is the same operation as sendMeta except we pass an ID
            const modalData = this.$store.getters.getModalData('offence');
            const sendObj = {
                id: this.offence.id,
                CitizenId: modalData.entity.id,
                date: this.offence.date,
                location: this.offence.location,
                time: this.offence.time,
                charges: this.offence.charges
            };
            this.sendClientMessage('sendOffenceMeta', sendObj);
        },
        saveTicket() {
            const modalData = this.$store.getters.getModalData('offence');
            const officer = this.$store.getters.getActiveOfficer;
            const ticket = this.offence.ticket;
            const sendObj = {
                date: this.offence.ticket.date,
                time: this.offence.ticket.time,
                location: this.offence.ticket.location,
                CitizenId: modalData.entity.id,
                OffenceId: this.offence.id,
                OfficerId: officer.id,
                points: ticket.points,
                fine: ticket.fine,
                notes: ticket.notes
            };
            if (ticket.id) {
                sendObj.id = ticket.id;
            }
            this.sendClientMessage('saveTicket', sendObj);
        },
        offenceToTags(input) {
            return input.map(({ id, name }) => ({ id, text: name }));
        },
        tagsToOffence(input) {
            return input.map(({ id, text }) => ({ id, name: text }));
        }
    }
};
</script>

<style>
.offence {
    display: flex;
    flex-direction: column;
}
.continue {
    display: flex;
    justify-content: flex-end;
    margin-top: 10px;
}
.meta {
    display: flex;
    justify-content: flex-end;
}
.meta input,
.tickets input,
.tickets textarea {
    margin-right: 10px;
    padding: 10px;
    border: 0;
    outline: 0;
    background: rgba(255, 255, 255, 0.1);
    color: rgba(255, 255, 255, 0.5);
    font-size: 14px;
}
.meta input::placeholder,
.tickets input::placeholder,
.tickets textarea::placeholder {
    color: rgba(255, 255, 255, 0.5);
}
.meta input:last-child,
.tickets input:last-child {
    margin-right: 0;
}
.operations {
    margin-top: 20px;
    border: 2px solid rgba(255, 255, 255, 0.3);
}
.tablist {
    display: flex;
    border-bottom: 1px solid rgba(255, 255, 255, 0.3);
}
.tab {
    margin: 0 10px;
}
.tab:first-child {
    margin-left: 0;
}
.tab:last-child {
    margin-right: 0;
}
button.tab {
    background: transparent;
    border: 0;
    padding: 10px 20px;
    color: rgba(255, 255, 255, 0.7);
    cursor: pointer;
    outline: none;
}
button.tab.selected {
    background: #333;
}
.tickets-container,
.charges-container,
.arrest-container {
    display: flex;
    flex-direction: column;
}
.charges-content,
.arrest-content {
    flex: 1;
    margin-top: 20px;
}
.content {
    padding: 20px;
}
.ticket-content {
    margin-top: 20px;
    flex: 1;
    display: grid;
    grid-template-columns: 1fr 1fr;
    grid-template-rows: 1fr 3fr;
    grid-column-gap: 20px;
    grid-row-gap: 20px;
    justify-items: stretch;
    align-items: stretch;
}
.ticket-input {
    display: flex;
}
.tickets input {
    flex-grow: 1;
}
.tickets .notes {
    grid-column: span 2;
}
.tickets textarea {
    flex-grow: 1;
    margin-right: 0;
    resize: none;
}
.actionlist {
    display: flex;
    padding-top: 20px;
    justify-content: flex-end;
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
