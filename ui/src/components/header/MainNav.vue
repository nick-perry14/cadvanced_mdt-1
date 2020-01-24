<template>
    <div id="main_nav">
        <ul id="top_level">
            <router-link tag="li" to="/status">Status</router-link>
            <li class="dropdown_trigger">
                Search
                <ul class="dropdown_container">
                    <router-link tag="li" to="/search/citizens">Citizens</router-link>
                    <router-link tag="li" to="/search/vehicles">Vehicles</router-link>
                    <router-link tag="li" to="/search/incidents">Incidents</router-link>
                    <router-link tag="li" to="/search/bolo">BOLO</router-link>
                </ul>
            </li>
            <li class="dropdown_trigger">
                Create
                <ul class="dropdown_container">
                    <router-link tag="li" to="/create/incident">Incident</router-link>
                    <router-link tag="li" to="/create/bolo">BOLO</router-link>
                </ul>
            </li>
            <router-link tag="li" to="/messaging">Messaging</router-link>
            <router-link tag="li" to="/notes">Notes</router-link>
        </ul>
    </div>
</template>

<style scoped>
#main_nav {
    flex: 8 8 0;
}
ul {
    list-style-type: none;
    margin: 0;
    padding: 0;
}
li.router-link-active {
    color: #00b2ff;
}
#top_level {
    display: flex;
}
#top_level > li:first-child {
    border-left: 0;
    padding-left: 0;
}
#top_level > li:last-child {
    border-right: 0;
    padding-right: 0;
}
#top_level > li {
    padding: 0 15px;
    border-right: 1px solid rgba(255, 255, 255, 0.71);
    border-left: 1px solid rgba(255, 255, 255, 0.71);
    cursor: pointer;
    position: relative;
}
.dropdown_trigger:hover .dropdown_container,
.dropdown_container:hover {
    display: flex;
}
.dropdown_container {
    display: none;
    flex-direction: column;
    position: absolute;
    top: 1.2em;
    left: 0;
    background: #333;
}
.dropdown_container li {
    padding: 10px;
    border-top: 1px solid rgba(255, 255, 255, 0.7);
    border-right: 1px solid rgba(255, 255, 255, 0.7);
    border-left: 1px solid rgba(255, 255, 255, 0.7);
}
.dropdown_container li:last-child {
    border-bottom: 1px solid rgba(255, 255, 255, 0.7);
}
</style>
