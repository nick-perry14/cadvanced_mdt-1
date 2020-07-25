<template>
    <div class="incident">
        <SectionProperty class="section" label="Incident" />
        <div class="details">
            <div class="time-location">
                <div class="spread">
                    <Property class="incident-date" :value="incident.date" />
                    &nbsp;
                    <Property class="incident-time" :value="incident.time" />
                </div>
                <Property class="location" :value="incident.location" />
            </div>
            <div class="arrest">
                <div class="label">Arrest</div>
                <div class="arrest-details">
                    <div v-if="!incident.arrest.id">
                        Not made
                    </div>
                    <div v-if="incident.arrest.id">
                        <div class="arrest-date-time">
                            <div class="spread">
                                <Property
                                    class="arrest-date"
                                    :value="incident.arrest.date"
                                />
                                &nbsp;
                                <Property
                                    class="arrest-time"
                                    :value="incident.arrest.time"
                                />
                            </div>
                        </div>
                        <div class="arrest-officer">
                            <span class="label">Arresting officer</span>
                            <div class="spread">
                                <Property
                                    :value="incident.arrest.officer.firstName"
                                />
                                &nbsp;
                                <Property
                                    :value="incident.arrest.officer.lastName"
                                />
                            </div>
                        </div>
                        <div class="arrest-charges">
                            <span class="label">Charges</span>
                            <Property
                                :value="
                                    incident.arrest.charges
                                        .map(c => c.name)
                                        .join(', ')
                                "
                            />
                        </div>
                    </div>
                </div>
            </div>
            <div class="charges">
                <div class="label">Charges</div>
                <div class="charges-details">
                    <div v-if="incident.charges.length === 0">
                        No charges filed
                    </div>
                    <div v-if="incident.charges.length > 0">
                        <Property
                            :value="
                                incident.charges.map(c => c.name).join(', ')
                            "
                        />
                    </div>
                </div>
            </div>
            <div class="tickets">
                <div class="label">Ticket</div>
                <div class="ticket-list">
                    <div v-if="!incident.ticket.id">
                        Not issued
                    </div>
                    <div v-if="incident.ticket.id">
                        <ul>
                            <li>
                                <Property
                                    :label="'Date & time'"
                                    :value="
                                        incident.ticket.date +
                                            ' ' +
                                            incident.ticket.time
                                    "
                                />
                            </li>
                            <li>
                                <Property
                                    :label="'Location'"
                                    :value="incident.ticket.location"
                                />
                            </li>
                            <li class="ticket-officer">
                                <Property
                                    :label="'Issuing officer'"
                                    :value="incident.ticket.officer.firstName"
                                />
                                &nbsp;
                                <Property
                                    :value="incident.ticket.officer.lastName"
                                />
                            </li>
                            <li>
                                <Property
                                    :label="'Points issued'"
                                    :value="incident.ticket.points"
                                />
                            </li>
                            <li>
                                <Property
                                    :label="'Fine issued'"
                                    :value="incident.ticket.fine"
                                />
                            </li>
                            <li>
                                <Property
                                    :label="'Notes'"
                                    :value="incident.ticket.notes"
                                />
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="edit">
                <MiniButton
                    @miniClick="openOffencesModal()"
                    text="Edit offence"
                    colour="rgba(0,0,0,0.2)"
                    borderRadius="3px"
                    icon="fa-pen-alt"
                    padding="6px 8px"
                />
                <MiniButton
                    @miniClick="deleteOffence()"
                    text="Delete offence"
                    colour="rgba(255,255,0,0.5)"
                    borderRadius="3px"
                    icon="fa-trash-alt"
                    padding="6px 8px"
                />
            </div>
        </div>
    </div>
</template>

<script>
import Property from './Property.vue';
import SectionProperty from './SectionProperty.vue';
import MiniButton from '../../MiniButton.vue';
import clientSender from '../../../mixins/clientSender';
export default {
    props: {
        incident: {
            type: Object,
            required: true
        },
        citizen: {
            type: Object,
            required: true
        },
        index: {
            type: Number,
            required: true
        }
    },
    mixins: [clientSender],
    components: {
        Property,
        SectionProperty,
        MiniButton
    },
    methods: {
        openOffencesModal() {
            this.$store.commit('setModal', {
                type: 'offence',
                data: {
                    open: true,
                    type: 'Citizen',
                    entity: this.citizen,
                    updateMutation: 'updateCitizenSearchResult',
                    offenceIndex: this.index
                }
            });
        },
        deleteOffence() {
            this.sendClientMessage('deleteOffence', {
                id: this.incident.id,
                CitizenId: this.citizen.id
            });
        }
    }
};
</script>

<style scoped>
.incident {
    color: rgba(255, 255, 255, 0.7);
    font-size: 14px;
    min-height: 40px;
    display: flex;
    border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}
.incident:last-child {
    border-bottom: 0;
}
.label {
    font-weight: bold;
}
.details {
    display: flex;
    flex-grow: 1;
    align-items: stretch;
    line-height: 18px;
}
.time-location {
    padding: 10px 15px;
    flex-basis: 15%;
    align-items: top;
    border-right: 1px solid rgba(255, 255, 255, 0.1);
}
.spread {
    display: flex;
}
.charges {
    padding: 10px 15px;
    flex-basis: 20%;
    display: flex;
    align-items: top;
    border-right: 1px solid rgba(255, 255, 255, 0.1);
}
.arrest {
    padding: 10px 15px;
    flex-basis: 30%;
    display: flex;
    align-items: top;
    border-right: 1px solid rgba(255, 255, 255, 0.1);
}
.arrest-details,
.charges-details {
    padding-left: 30px;
}
.arrest-date-time,
.arrest-officer {
    margin-right: 15px;
}
.tickets {
    padding: 10px 15px;
    display: flex;
    align-items: top;
    flex: 1;
}
.ticket-list {
    padding-left: 30px;
}
.ticket-officer {
    display: flex;
    white-space: nowrap;
}
.edit {
    padding: 10px 15px;
    align-items: top;
    display: flex;
    flex-direction: column;
}
.edit > * {
    margin-bottom: 10px;
}
.edit > *:last-child {
    margin-bottom: 0;
}
</style>
