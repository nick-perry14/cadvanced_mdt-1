<template>
    <div id="main_nav">
        <ul>
            <router-link tag="li" to="/status">Status</router-link>
            <router-link tag="li" to="/search">Search</router-link>
            <router-link tag="li" to="/create">Create</router-link>
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
    overflow: hidden;
}
li {
    float: left;
    padding: 0 15px;
    border-right: 1px solid rgba(255, 255, 255, 0.71);
    border-left: 1px solid rgba(255, 255, 255, 0.71);
    cursor: pointer;
}
li.router-link-active {
    color: #00b2ff;
}
li:first-child {
    border-left: 0;
    padding-left: 0;
}
li:last-child {
    border-right: 0;
    padding-right: 0;
}
</style>
