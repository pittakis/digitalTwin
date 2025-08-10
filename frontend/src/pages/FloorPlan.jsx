import React from "react";
import { useNavigate } from "react-router-dom";

const floors = [
    { id: 0, name: "Floor 0", img: "/floor_0_captions.jpg", alt: "Floor 0 plan" },
    { id: 1, name: "Floor 1", img: "/floor_1_captions.jpg", alt: "Floor 1 plan" },
];

const FloorPlan = () => {
    const navigate = useNavigate();

    const goTo3D = (floor) => {
        navigate(`/building-3d/${floor}`);
    };

    return (
        <div style={{ padding: "2rem" }}>
            {/* Back button */}
            <button
                onClick={() => navigate(-1)}
                style={styles.backBtn}
                aria-label="Go back"
            >
                ⬅ Back
            </button>

            <h1 style={{ textAlign: "center", fontSize: 28, marginBottom: "1.5rem" }}>
                Floor Plans
            </h1>
            <div style={{ padding: 20, maxWidth: 1200, margin: "0 auto" }}>
                {/* Gallery */}
                <div
                    style={{
                        display: "grid",
                        gridTemplateColumns: "repeat(auto-fit, minmax(260px, 1fr))",
                        gap: 20,
                    }}
                >
                    {floors.map((f) => (
                        <div
                            key={f.id}
                            style={{
                                border: "1px solid #e5e7eb",
                                padding: "1rem",
                                borderRadius: 12,
                                overflow: "hidden",
                                background: "#fff",
                                boxShadow: "0 1px 2px rgba(0,0,0,0.04)",
                                textAlign: "center",
                            }}
                        >
                            {/* Clickable image */}
                            <a href={f.img} target="_blank" rel="noopener noreferrer">
                                <div
                                    style={{
                                        aspectRatio: "4 / 3",
                                        background: "#fafafa",
                                        display: "flex",
                                        alignItems: "center",
                                        justifyContent: "center",
                                        overflow: "hidden",
                                        cursor: "pointer",
                                    }}
                                >
                                    <img
                                        src={f.img}
                                        alt={f.alt}
                                        style={{
                                            width: "100%",
                                            height: "100%",
                                            objectFit: "contain",
                                        }}
                                        loading="lazy"
                                    />
                                </div>
                            </a>

                            <div style={{ padding: 16 }}>
                                <button
                                    onClick={() => goTo3D(f.id)}
                                    style={{
                                        width: "auto",
                                        padding: "10px 16px",
                                        backgroundColor: "#007bff",
                                        color: "#fff",
                                        border: "none",
                                        borderRadius: 8,
                                        cursor: "pointer",
                                        fontSize: 16,
                                    }}
                                >
                                    Proceed to 3D Building View for floor {f.id}
                                </button>
                            </div>
                        </div>
                    ))}
                </div>
            </div>
        </div>
    );
};

const styles = {
    backBtn: {
        background: "none",
        border: "none",
        cursor: "pointer",
        fontSize: "1rem",
        marginBottom: "1rem",
        color: "#007BFF",
    }
};

export default FloorPlan;
