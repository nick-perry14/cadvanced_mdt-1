<template>
    <div>
        <Incident
            v-for="(incident, index) in citizen.offences"
            :key="incident.id"
            :incident="incident"
            :citizen="citizen"
            :index="index"
        />
    </div>
</template>

<script>
import Incident from './Incident.vue';
import clientSender from '../../../mixins/clientSender';
export default {
    props: {
        citizen: {
            type: Object,
            required: true
        }
    },
    components: {
        Incident
    },
    mixins: [clientSender],
    mounted: function() {
        this.sendClientMessage('getCitizenOffences', { id: this.citizen.id });
    }
};
</script>
