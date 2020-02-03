<template>
    <div id="search-results">
        <Citizen
            v-for="citizen in results"
            v-on:openCitizenResult="setOpen($event)"
            :key="citizen.id"
            :citizen="citizen"
            :open="open"
            :setOpen="setOpen"
        ></Citizen>
    </div>
</template>

<script>
import Citizen from '../../../reusable/Citizen/Citizen.vue';
export default {
    components: {
        Citizen
    },
    data: function() {
        return {
            open: '0'
        };
    },
    methods: {
        setOpen(open) {
            this.open = open;
        }
    },
    computed: {
        results() {
            return JSON.parse(
                `[{"id":"1","firstName":"Mike","lastName":"Jenkins","address":"65 Green Street, Cambridge","postalCode":"CB2 4YR","GenderId":"1","gender":{"id":"1","name":"Male","__typename":"Gender"},"EthnicityId":"1","ethnicity":{"id":"1","name":"White","__typename":"Ethnicity"},"vehicles":[{"id":"1","colour":"Red","licencePlate":"PY785XKS","vehicleModel":{"id":"2","name":"Ford Fiesta","__typename":"VehicleModel"},"insuranceStatus":{"id":"2","name":"Invalid","__typename":"InsuranceStatus"},"__typename":"Vehicle"},{"id":"2","colour":"Red","licencePlate":"PY785XKS","vehicleModel":{"id":"2","name":"Ford Fiesta","__typename":"VehicleModel"},"insuranceStatus":{"id":"2","name":"Invalid","__typename":"InsuranceStatus"},"__typename":"Vehicle"},{"id":"3","colour":"Red","licencePlate":"PY785XKS","vehicleModel":{"id":"2","name":"Ford Fiesta","__typename":"VehicleModel"},"insuranceStatus":{"id":"2","name":"Invalid","__typename":"InsuranceStatus"},"__typename":"Vehicle"}],"weapons":[{"id":"1","weaponType":{"id":"1","name":"Handgun","__typename":"WeaponType"},"weaponStatus":{"id":"1","name":"Legal","__typename":"WeaponStatus"},"__typename":"Weapon"},{"id":"2","weaponType":{"id":"2","name":"Pistol","__typename":"WeaponType"},"weaponStatus":{"id":"2","name":"Stolen","__typename":"WeaponStatus"},"__typename":"Weapon"},{"id":"3","weaponType":{"id":"3","name":"Rifle","__typename":"WeaponType"},"weaponStatus":{"id":"2","name":"Stolen","__typename":"WeaponStatus"},"__typename":"Weapon"}],"licences":[{"id":"1","licenceType":{"id":"1","name":"Driving","__typename":"LicenceType"},"licenceStatus":{"id":"1","name":"Valid","__typename":"LicenceStatus"},"__typename":"Licence"},{"id":"2","licenceType":{"id":"2","name":"Weapon","__typename":"LicenceType"},"licenceStatus":{"id":"2","name":"Invalid","__typename":"LicenceStatus"},"__typename":"Licence"}],"warrants":[{"id":"1","validFrom":"01/01/2019","validTo":"01/01/2021","details":"Search premises","__typename":"Warrant"}],"dateOfBirth":"17/10/1973","weight":"73kg","height":"5'8","hair":"Brown","eyes":"Blue","active":false,"createdAt":"Thu Jan 30 2020 16:06:07 GMT+0000 (Greenwich Mean Time)","__typename":"Citizen", "incidents":[{"id":"1","date":"30/01/2020","time":"16:07","location":"Corner of Dark Red Valley Street and Green Street","ArrestId":null,"arrest":{"id":"1","date":"30/01/2020","time":"16:07","OfficerId":"1","officer":{"id":"1","firstName":"Pete","lastName":"Jones","__typename":"Officer"},"charges":[{"id":"2","name":"Breach of the peace","__typename":"Charge"},{"id":"1","name":"Drunk and disorderly","__typename":"Charge"}],"__typename":"Arrest"},"charges":[],"TicketId":null,"ticket":{"id":"1","date":"30/01/2020","time":"16:07","location":"Red Street","points":"3","fine":"£50","notes":"What a bad boy, I am not impressed with this chap, he's very naughty. But I need to write more to see what a long note looks like","OfficerId":"1","officer":{"id":"1","firstName":"Pete","lastName":"Jones","__typename":"Officer"},"__typename":"Ticket"},"__typename":"Offence"},{"id":"2","date":"17/12/2019","time":"12:31","location":"Yellow Street","ArrestId":null,"arrest":null,"charges":[{"id":"1","name":"Drunk and disorderly","__typename":"Charge"}],"TicketId":null,"ticket":null,"__typename":"Offence"}]},
                {"id":"2","firstName":"Mike","lastName":"Jenkins","address":"65 Green Street, Cambridge","postalCode":"CB2 4YR","GenderId":"1","gender":{"id":"1","name":"Male","__typename":"Gender"},"EthnicityId":"1","ethnicity":{"id":"1","name":"White","__typename":"Ethnicity"},"vehicles":[{"id":"1","colour":"Red","licencePlate":"PY785XKS","vehicleModel":{"id":"2","name":"Ford Fiesta","__typename":"VehicleModel"},"insuranceStatus":{"id":"2","name":"Invalid","__typename":"InsuranceStatus"},"__typename":"Vehicle"},{"id":"2","colour":"Red","licencePlate":"PY785XKS","vehicleModel":{"id":"2","name":"Ford Fiesta","__typename":"VehicleModel"},"insuranceStatus":{"id":"2","name":"Invalid","__typename":"InsuranceStatus"},"__typename":"Vehicle"},{"id":"3","colour":"Red","licencePlate":"PY785XKS","vehicleModel":{"id":"2","name":"Ford Fiesta","__typename":"VehicleModel"},"insuranceStatus":{"id":"2","name":"Invalid","__typename":"InsuranceStatus"},"__typename":"Vehicle"}],"weapons":[{"id":"1","weaponType":{"id":"1","name":"Handgun","__typename":"WeaponType"},"weaponStatus":{"id":"1","name":"Legal","__typename":"WeaponStatus"},"__typename":"Weapon"},{"id":"2","weaponType":{"id":"2","name":"Pistol","__typename":"WeaponType"},"weaponStatus":{"id":"2","name":"Stolen","__typename":"WeaponStatus"},"__typename":"Weapon"},{"id":"3","weaponType":{"id":"3","name":"Rifle","__typename":"WeaponType"},"weaponStatus":{"id":"2","name":"Stolen","__typename":"WeaponStatus"},"__typename":"Weapon"}],"licences":[{"id":"1","licenceType":{"id":"1","name":"Driving","__typename":"LicenceType"},"licenceStatus":{"id":"1","name":"Valid","__typename":"LicenceStatus"},"__typename":"Licence"},{"id":"2","licenceType":{"id":"2","name":"Weapon","__typename":"LicenceType"},"licenceStatus":{"id":"2","name":"Invalid","__typename":"LicenceStatus"},"__typename":"Licence"}],"warrants":[{"id":"1","validFrom":"01/01/2019","validTo":"01/01/2021","details":"Search premises","__typename":"Warrant"}],"dateOfBirth":"17/10/1973","weight":"73kg","height":"5'8","hair":"Brown","eyes":"Blue","active":false,"createdAt":"Thu Jan 30 2020 16:06:07 GMT+0000 (Greenwich Mean Time)","__typename":"Citizen", "incidents":[{"id":"1","date":"30/01/2020","time":"16:07","location":"Corner of Dark Red Valley Street and Green Street","ArrestId":null,"arrest":{"id":"1","date":"30/01/2020","time":"16:07","OfficerId":"1","officer":{"id":"1","firstName":"Pete","lastName":"Jones","__typename":"Officer"},"charges":[{"id":"2","name":"Breach of the peace","__typename":"Charge"},{"id":"1","name":"Drunk and disorderly","__typename":"Charge"}],"__typename":"Arrest"},"charges":[],"TicketId":null,"ticket":{"id":"1","date":"30/01/2020","time":"16:07","location":"Red Street","points":"3","fine":"£50","notes":"What a bad boy","OfficerId":"1","officer":{"id":"1","firstName":"Pete","lastName":"Jones","__typename":"Officer"},"__typename":"Ticket"},"__typename":"Offence"},{"id":"2","date":"17/12/2019","time":"12:31","location":"Yellow Street","ArrestId":null,"arrest":null,"charges":[{"id":"1","name":"Drunk and disorderly","__typename":"Charge"}],"TicketId":null,"ticket":null,"__typename":"Offence"}]}]`
            );
        }
    }
};
</script>

<style scoped>
#search_results {
    overflow-y: scroll;
}
</style>
