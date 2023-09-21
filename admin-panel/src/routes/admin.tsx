/* eslint-disable import/no-anonymous-default-export */

import { Calendar, People, Building, SmartCar } from "iconsax-react";
import Events from "../pages/admin/event";
import TourGuides from "../pages/admin/tourGuide";
import Hotels from "../pages/admin/hotel";
import Cabs from "../pages/admin/cab";

const size = 22;

export default [
    {
        name: 'Events',
        path: '/events',
        icon: <Calendar size={size} color="#fff"/>,
        component: <Events/>
    },
    {
        name: 'Tour Guides',
        path: '/tour-guides',
        icon: <People size={size} color="#fff"/>,
        component: <TourGuides/>
    },
    {
        name: 'Hotels',
        path: '/hotels',
        icon: <Building size={size} color="#fff"/>,
        component: <Hotels/>
    },
    {
        name: 'Cab Drivers',
        path: '/cab-drivers',
        icon: <SmartCar size={size} color="#fff"/>,
        component: <Cabs/>
    }
];