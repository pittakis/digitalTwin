import React, { useEffect, useRef, useState } from 'react';
import axios from 'axios';
import * as THREE from 'three';
import { GLTFLoader } from 'three/examples/jsm/loaders/GLTFLoader.js';
import { OrbitControls } from 'three/examples/jsm/controls/OrbitControls.js';
import { useNavigate } from 'react-router-dom';
import { Info } from 'lucide-react';
import { Link } from "react-router-dom";


const FloorPlan = () => {
    let floor = -1;
    return (
        <div style={{ padding: '20px' }}>
            <h1>Floor Plan</h1>
            <p>This page is under construction. Please check back later for updates.</p>
            <p>For now, you can explore the 3D building view.</p>
            <button onClick={() => { floor = 0; window.location.href = `/building-3d/${floor}`}} style={{
                padding: '10px 20px',
                backgroundColor: '#007bff',
                color: '#fff',
                border: 'none',
                borderRadius: '5px',
                cursor: 'pointer',
                fontSize: '16px'
            }}>
                Go to 3D Building View for floor 0
            </button>
                        <button onClick={() => { floor = 1; window.location.href = `/building-3d/${floor}`}} style={{
                padding: '10px 20px',
                backgroundColor: '#007bff',
                color: '#fff',
                border: 'none',
                borderRadius: '5px',
                cursor: 'pointer',
                fontSize: '16px'
            }}>
                Go to 3D Building View for floor 1
            </button>
        </div>
    );
}

export default FloorPlan;