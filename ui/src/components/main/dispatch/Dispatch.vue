<template>
    <div id="dispatch-container">
        <div id="calls">
            <Calls />
        </div>
        <div id="units">
            <Units />
        </div>
    </div>
</template>

<script>
import Calls from './calls/Calls.vue';
import Units from '../status/units/Units.vue';
export default {
    components: {
        Calls,
        Units
    }
};
</script>

<style scoped>
#dispatch-container {
    display: flex;
}
#calls,
#units {
    flex: 1;
}
#calls {
    margin-right: 20px;
}
#units {
    margin-left: 20px;
}
</style>
