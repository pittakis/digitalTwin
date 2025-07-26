import React, { useEffect, useRef, useState } from 'react';
import axios from 'axios';
import * as THREE from 'three';
import { GLTFLoader } from 'three/examples/jsm/loaders/GLTFLoader.js';
import { OrbitControls } from 'three/examples/jsm/controls/OrbitControls.js';
import { useNavigate } from 'react-router-dom';
import { Info } from 'lucide-react';

const BuildingViewer = () => {
  const mountRef = useRef(null);
  const [sensorNames, setSensorNames] = useState([]);
  const [showSensorInfo, setShowSensorInfo] = useState(false);
  const [selectedSensor, setSelectedSensor] = useState(null);
  const [selectedName, setSelectedName] = useState('none');
  const [loading, setLoading] = useState(true);
  const [showInstructions, setShowInstructions] = useState(false);

  const selectedNameRef = useRef('none');
  const sceneRef = useRef();
  const cameraRef = useRef();
  const controlsRef = useRef();
  const showSensorInfoRef = useRef(showSensorInfo);
  const navigate = useNavigate();

  const originalColors = useRef(new Map());
  const movement = useRef({ forward: false, backward: false, left: false, right: false });
  const speedRef = useRef(0.05);
  const speedMultiplierRef = useRef(1);

  // Fetch sensor names once
  useEffect(() => {
    axios.get('http://localhost:7781/api/getSensorNames')
      .then(res => setSensorNames(res.data))
      .catch(err => console.error('Failed to fetch sensor names', err));
  }, []);

  useEffect(() => { showSensorInfoRef.current = showSensorInfo; }, [showSensorInfo]);

  // Initialize Three.js once
  useEffect(() => {
    const mount = mountRef.current;
    if (!mount) return;

    const scene = new THREE.Scene();
    scene.background = new THREE.Color(0xeeeeee);
    sceneRef.current = scene;

    const raycaster = new THREE.Raycaster();
    const mouse = new THREE.Vector2();

    const camera = new THREE.PerspectiveCamera(75, mount.clientWidth / mount.clientHeight, 0.1, 1000);
    camera.position.set(2, 2, 4);
    cameraRef.current = camera;

    const renderer = new THREE.WebGLRenderer({ antialias: true });
    renderer.setSize(mount.clientWidth, mount.clientHeight);
    mount.appendChild(renderer.domElement);

    // Click & wheel
    const onClick = e => {
      if (!showSensorInfoRef.current) return;
      const rect = mount.getBoundingClientRect();
      mouse.x = ((e.clientX - rect.left) / rect.width) * 2 - 1;
      mouse.y = -((e.clientY - rect.top) / rect.height) * 2 + 1;
      raycaster.setFromCamera(mouse, camera);
      const hits = raycaster.intersectObjects(scene.children, true);
      if (!hits.length) return;
      let obj = hits[0].object;
      while (obj && !obj.name) obj = obj.parent;
      if (obj && sensorNames.includes(obj.name)) {
        const name = obj.name;
        if (selectedNameRef.current === name) {
          resetHighlights();
          setSelectedSensor(null);
          setSelectedName('none');
          selectedNameRef.current = 'none';
        } else {
          handleSensorSelect(name);
        }
      }
      console.log('Clicked on:', obj ? obj.name : 'none');
      console.log('parent:', obj ? obj.parent.name : 'none');
    };
    const onWheel = e => {
      speedMultiplierRef.current = Math.max(0.01, Math.min(5, speedMultiplierRef.current - e.deltaY * 0.001));
    };
    mount.addEventListener('click', onClick);
    mount.addEventListener('wheel', onWheel);

    const controls = new OrbitControls(camera, renderer.domElement);
    controls.target.set(0, 1, 0);
    controls.enableZoom = false;
    controls.update();
    controlsRef.current = controls;

    scene.add(new THREE.HemisphereLight(0xffffff, 0x444444, 1.2));
    const dirLight = new THREE.DirectionalLight(0xffffff, 1);
    dirLight.position.set(3, 10, 10);
    scene.add(dirLight);

    // Load model
    new GLTFLoader().load(
      '/fasada_v2.glb',
      gltf => {
        scene.add(gltf.scene);
        gltf.scene.traverse(child => {
          if (!child.isMesh) return;

          const name = child.name.toLowerCase();
          const parentName = child.parent?.name?.toLowerCase() || '';

          // Wall
          if (name.includes('wall') || parentName.includes('wall')) {
            child.material = new THREE.MeshStandardMaterial({
              color: 0xf5e1c0, // light plaster/beige
              roughness: 0.9,
              metalness: 0.1
            });

            // Floor
          } else if (name.includes('floor') || parentName.includes('floor')) {
  const texture = new THREE.TextureLoader().load('textures/floor_texture.jpg');
  texture.wrapS = THREE.RepeatWrapping;
  texture.wrapT = THREE.RepeatWrapping;
  texture.repeat.set(4, 4); // Adjust tiling (4x4 = repeated pattern)

  child.material = new THREE.MeshStandardMaterial({
    map: texture,
    roughness: 0.7,
    metalness: 0.1
  });
} else if (child.name.includes('IfcGeographicElementToposolidOgólne_—_1000_mm618174')) {
            child.material = new THREE.MeshStandardMaterial({
              color: 0x3a6e3a, // rich green
              roughness: 1.0,
              metalness: 0.0
            });

            // Doors
          } else if (name.includes('door') || parentName.includes('door')) {
            child.material = new THREE.MeshStandardMaterial({
              color: 0x8b5a2b, // warm brown wood
              roughness: 0.6,
              metalness: 0.3
            });

            // Windows
          } else if (name.includes('window') || parentName.includes('window')) {
            child.material = new THREE.MeshPhysicalMaterial({
              color: 0xa0a0a0,
              roughness: 0.1,
              metalness: 0.0,
              transparent: true,
              opacity: 0.4,
              // transmission: 1.0,  // better glass realism (WebGL2+ only) takes too much performance
              thickness: 0.2,
              clearcoat: 1.0,
              clearcoatRoughness: 0.1
            });
          }
        });

        setLoading(false);
      },
      undefined,
      err => console.error('Error loading model:', err)
    );

    // Keyboard movement & resize
    const down = e => {
      if (e.code === 'KeyW') movement.current.forward = true;
      if (e.code === 'KeyS') movement.current.backward = true;
      if (e.code === 'KeyA') movement.current.left = true;
      if (e.code === 'KeyD') movement.current.right = true;
    };
    const up = e => {
      if (e.code === 'KeyW') movement.current.forward = false;
      if (e.code === 'KeyS') movement.current.backward = false;
      if (e.code === 'KeyA') movement.current.left = false;
      if (e.code === 'KeyD') movement.current.right = false;
    };
    const onResize = () => {
      const w = mount.clientWidth;
      const h = mount.clientHeight;
      camera.aspect = w / h;
      camera.updateProjectionMatrix();
      renderer.setSize(w, h);
    };
    window.addEventListener('keydown', down);
    window.addEventListener('keyup', up);
    window.addEventListener('resize', onResize);

    const animate = () => {
      requestAnimationFrame(animate);
      const dirZ = (movement.current.forward ? 1 : 0) + (movement.current.backward ? -1 : 0);
      const dirX = (movement.current.right ? 1 : 0) + (movement.current.left ? -1 : 0);
      const fwd = new THREE.Vector3();
      camera.getWorldDirection(fwd);
      fwd.normalize();
      const strafe = new THREE.Vector3().crossVectors(fwd, camera.up).normalize();
      const delta = new THREE.Vector3()
        .addScaledVector(fwd, speedRef.current * speedMultiplierRef.current * dirZ)
        .addScaledVector(strafe, speedRef.current * speedMultiplierRef.current * dirX);
      camera.position.add(delta);
      controls.target.add(delta);
      controls.update();
      renderer.render(scene, camera);
    };
    animate();

    return () => {
      window.removeEventListener('keydown', down);
      window.removeEventListener('keyup', up);
      window.removeEventListener('resize', onResize);
      mount.removeEventListener('click', onClick);
      mount.removeEventListener('wheel', onWheel);
      mount.removeChild(renderer.domElement);
    };
  }, [sensorNames]);

  // Highlight
  const highlightObject = object => {
    object.traverse(child => {
      if (child.isMesh) {
        const map = originalColors.current;
        if (!map.has(child.uuid)) map.set(child.uuid, child.material.color.clone());
        child.material = child.material.clone();
        child.material.color.set(0xff0000);
      }
    });
  };

  // Reset highlights
  const resetHighlights = () => {
    sceneRef.current.traverse(child => {
      if (child.isMesh) {
        const map = originalColors.current;
        if (map.has(child.uuid)) child.material.color.copy(map.get(child.uuid));
      }
    });
    originalColors.current.clear();
  };

  // Select sensor
  const handleSensorSelect = async name => {
    try {
      if (selectedNameRef.current === name) {
        resetHighlights(); setSelectedSensor(null); setSelectedName('none'); selectedNameRef.current = 'none'; return;
      }
      const res = await axios.get(`http://localhost:7781/api/getSensorData/${name}`);
      setSelectedSensor(res.data);
      const obj = sceneRef.current.getObjectByName(name);
      if (!obj) return;
      resetHighlights(); highlightObject(obj);
      const box = new THREE.Box3().setFromObject(obj);
      const center = new THREE.Vector3(); box.getCenter(center);
      controlsRef.current.target.copy(center);
      const size = new THREE.Vector3(); box.getSize(size);
      const maxDim = Math.max(size.x, size.y, size.z);
      const distance = maxDim * 3;
      const quaternion = new THREE.Quaternion(); obj.getWorldQuaternion(quaternion);
      const front = new THREE.Vector3(0, 0, 1).applyQuaternion(quaternion).normalize();
      cameraRef.current.position.copy(center.clone().add(front.multiplyScalar(distance)));
      controlsRef.current.update();
      setSelectedName(name); selectedNameRef.current = name;
    } catch (err) {
      console.error('Failed to fetch sensor data:', err);
    }
  };

  return (
    <>
      {/* Loading overlay with spinner */}
      {loading && (
        <div style={{
          position: 'absolute', top: 0, left: 0, width: '100%', height: '100%',
          background: 'rgba(0,0,0,0.5)', display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center', zIndex: 20
        }}>
          <svg width="60" height="60" viewBox="0 0 100 100" style={{ marginBottom: '1rem' }}>
            <circle cx="50" cy="50" r="32" strokeWidth="8" stroke="#fff" strokeDasharray="50.265" fill="none" strokeLinecap="round">
              <animateTransform attributeName="transform" type="rotate" repeatCount="indefinite" dur="1s" values="0 50 50;360 50 50" keyTimes="0;1" />
            </circle>
          </svg>
          <span style={{ color: 'white', fontSize: '1.2rem' }}>Loading 3D Model...</span>
        </div>
      )}

      {/* UI Bar */}
      <div style={styles.uiBar}>
        <button onClick={() => navigate(-1)} style={styles.backButton}>Back</button>
        <button onClick={() => { setShowSensorInfo(prev => { if (prev) { resetHighlights(); setSelectedSensor(null); setSelectedName('none'); selectedNameRef.current = 'none'; } return !prev; }); }} style={styles.toggleButton}>
          {showSensorInfo ? 'Hide Sensor Data' : 'Show Sensor Data'}
        </button>
        {showSensorInfo && (
          <select onChange={e => { const val = e.target.value; if (val === 'none') { resetHighlights(); setSelectedSensor(null); setSelectedName('none'); selectedNameRef.current = 'none'; } else { handleSensorSelect(val); } }} value={selectedName} style={styles.dropdown}>
            <option value="none">None</option>
            {sensorNames.map(name => <option key={name} value={name}>{name}</option>)}
          </select>
        )}
        <button onClick={() => setShowInstructions(prev => !prev)} style={styles.infoButton}><Info /></button>
      </div>

      {/* Instructions Modal */}
      {showInstructions && (
        <div style={styles.modalOverlay} onClick={() => setShowInstructions(false)}>
          <div style={styles.modal} onClick={e => e.stopPropagation()}>
            <h2>How to Use</h2>
            <ul>
              <li><strong>Move:</strong> Use <em>W</em>/<em>S</em>/<em>A</em>/<em>D</em> to fly in the direction the camera is pointing (Click to point to a direction).</li>
              <li><strong>Speed:</strong> Scroll up/down to adjust movement speed.</li>
              <li><strong>Select Sensor:</strong> Click on a sensor in the 3D model or choose from the dropdown.</li>
              <li><strong>Deselect:</strong> Click the same sensor again or select "None".</li>
            </ul>
            <button onClick={() => setShowInstructions(false)} style={styles.closeButton}>Close</button>
          </div>
        </div>
      )}

      {selectedSensor && showSensorInfo && (
        <div style={styles.sensorCard}>
          <h3>📍 Sensor Info</h3>
          {Object.entries(selectedSensor.latest_data || {}).map(([k, v]) => (
            <p key={k}><strong>{k}:</strong> {v}</p>
          ))}
        </div>
      )}

      <div ref={mountRef} style={{ width: '100%', height: '100vh', overflow: 'hidden' }} />
    </>
  );
};

const styles = {
  uiBar: {
    position: 'absolute', top: '20px', left: '20px', display: 'flex', gap: '0.5rem', zIndex: 10,
    background: 'rgba(255,255,255,0.9)', padding: '0.5rem', borderRadius: '10px', boxShadow: '0 2px 8px rgba(0,0,0,0.2)'
  },
  infoButton: { padding: '0.1rem 0.2rem', backgroundColor: 'transparent', color: '#007bff', border: 'none', borderRadius: '100%', cursor: 'pointer', fontSize: '1rem' },
  toggleButton: { padding: '0.4rem 0.8rem', backgroundColor: '#007bff', color: 'white', border: 'none', borderRadius: '5px', cursor: 'pointer' },
  dropdown: { padding: '0.4rem', borderRadius: '5px', border: '1px solid #ccc' },
  backButton: { padding: '0.4rem 0.8rem', backgroundColor: '#6c757d', color: 'white', border: 'none', borderRadius: '5px', cursor: 'pointer' },
  sensorCard: { position: 'absolute', top: '20px', right: '20px', background: '#fff', border: '1px solid #ddd', borderRadius: '10px', padding: '1rem', boxShadow: '0 2px 10px rgba(0,0,0,0.15)', zIndex: 10, minWidth: '220px', fontFamily: 'Segoe UI, sans-serif' },
  modalOverlay: { position: 'absolute', top: 0, left: 0, width: '100%', height: '100%', background: 'rgba(0,0,0,0.5)', display: 'flex', alignItems: 'center', justifyContent: 'center', zIndex: 20 },
  modal: { background: '#fff', borderRadius: '10px', padding: '1.5rem', maxWidth: '400px', boxShadow: '0 2px 10px rgba(0,0,0,0.2)' },
  closeButton: { marginTop: '1rem', padding: '0.4rem 0.8rem', backgroundColor: '#007bff', color: 'white', border: 'none', borderRadius: '5px', cursor: 'pointer' }
};

export default BuildingViewer;
