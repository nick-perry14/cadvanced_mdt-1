<template>
    <div class="vehicle">
        <SectionProperty class="section" label="Vehicle" />
        <div class="details">
            <div class="licence-plate">
                <Property :label="''" :value="vehicle.licencePlate" />
            </div>
            <div class="colour">
                <Property :label="''" :value="vehicle.colour" />
                &nbsp;
                <Property :label="''" :value="vehicle.vehicleModel.name" />
            </div>
            <div class="insurance">
                <Property
                    :label="'Insurance'"
                    :value="vehicle.insuranceStatus.name"
                />
            </div>
        </div>
    </div>
</template>

<script>
import Property from './Property.vue';
import SectionProperty from './SectionProperty.vue';
export default {
    props: ['vehicle'],
    components: {
        Property,
        SectionProperty
    }
};
</script>

<style scoped>
.vehicle {
    display: flex;
    color: rgba(255, 255, 255, 0.7);
    font-size: 14px;
    min-height: 40px;
}
.details {
    display: flex;
    align-items: center;
    flex-grow: 1;
    padding: 0 30px;
}
.licence-plate {
    margin-right: 30px;
}
.colour {
    display: flex;
}
.details > div.insurance {
    margin-left: auto;
}
</style>
