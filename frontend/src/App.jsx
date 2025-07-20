import { Routes, Route } from "react-router-dom";
import Login from "./pages/Login";
import Dashboard from "./pages/Dashboard";
import PMV from "./pages/PMV";
import Sensors from "./pages/Sensors";
import EnergyOverview from "./pages/EnergyOverview";
import HeaterOverview from "./pages/HeaterOverview";
import Building3D from "./pages/BuildingViewer";
import { ChatProvider } from "./components/chatbot";
import ChatWidget from "./components/chatbot";

function App() {
  return (
    <ChatProvider>
      <Routes>
        <Route path="/" element={<Login />} />
        <Route path="/dashboard" element={<Dashboard />} />
        <Route path="/pmv" element={<PMV />} />
        <Route path="/sensors" element={<Sensors />} />
        <Route path="/energy-overview" element={<EnergyOverview />} />
        <Route path="/heater-overview" element={<HeaterOverview />} />
        <Route path="/building-3d" element={<Building3D />} />
      </Routes>
      {location.pathname !== '/' && <ChatWidget />}
    </ChatProvider>
  );
}

export default App;