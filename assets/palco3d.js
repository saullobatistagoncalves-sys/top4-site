/* =========================================================
   TOP4 — palco 3D do topo da página
   Tênis em estúdio: pódio com aro dourado, luz de vitrine,
   giro arrastando e um passeio pelo produto ao rolar a página.
   ========================================================= */
import * as THREE from "three";
import { GLTFLoader } from "three/addons/loaders/GLTFLoader.js";
import { RoomEnvironment } from "three/addons/environments/RoomEnvironment.js";

const root = document.getElementById("palco");
if (root) iniciar();

function iniciar(){
  const sticky = root.querySelector(".palco-sticky");
  const holder = root.querySelector(".palco-canvas");
  const steps = [...root.querySelectorAll("[data-step]")];
  const dots = [...root.querySelectorAll(".palco-dots i")];
  const swatches = [...root.querySelectorAll("[data-cor]")];
  const reduced = matchMedia("(prefers-reduced-motion: reduce)").matches;
  const clamp = (v, a, b) => Math.min(b, Math.max(a, v));
  const smooth = t => t * t * (3 - 2 * t);
  const lerp = (a, b, t) => a + (b - a) * t;

  /* ---------- Rolagem: etapas do passeio (funciona mesmo sem 3D) ---------- */
  let prog = 0, etapaAtual = -1;
  function lerProgresso(){
    const r = root.getBoundingClientRect();
    const total = r.height - innerHeight;
    prog = total > 0 ? clamp(-r.top / total, 0, 1) : 0;
    root.style.setProperty("--p", prog.toFixed(4));
    const etapa = prog < 0.16 ? 0 : prog < 0.43 ? 1 : prog < 0.7 ? 2 : 3;
    if (etapa !== etapaAtual){
      etapaAtual = etapa;
      root.dataset.etapa = etapa;
      steps.forEach(s => s.classList.toggle("on", +s.dataset.step === etapa));
      dots.forEach((d, i) => d.classList.toggle("on", i === etapa));
    }
  }
  addEventListener("scroll", lerProgresso, { passive: true });
  addEventListener("resize", lerProgresso);
  lerProgresso();
  root.querySelectorAll(".palco-dots i").forEach((d, i) => d.addEventListener("click", () => {
    const total = root.offsetHeight - innerHeight;
    const alvo = [0, 0.3, 0.57, 0.86][i];
    scrollTo({ top: root.offsetTop + total * alvo, behavior: reduced ? "auto" : "smooth" });
  }));

  /* ---------- Cores ---------- */
  const CORES = {
    noite:   { nome: "Noite",   map: null, url: null },
    gelo:    { nome: "Gelo",    map: null, url: "assets/3d/cor-gelo.jpg" },
    grafite: { nome: "Grafite", map: null, url: "assets/3d/cor-grafite.jpg" }
  };
  let corAtual = "noite";
  function marcarCor(c){
    swatches.forEach(b => b.setAttribute("aria-checked", String(b.dataset.cor === c)));
    const nome = root.querySelector("[data-cor-nome]"); if (nome) nome.textContent = CORES[c].nome;
    root.dataset.cor = c;
    document.dispatchEvent(new CustomEvent("palco:cor", { detail: c }));
  }
  swatches.forEach(b => b.addEventListener("click", () => { corAtual = b.dataset.cor; marcarCor(corAtual); trocarCor && trocarCor(corAtual); }));
  let trocarCor = null;

  /* ---------- 3D ---------- */
  let gl = null;
  try { const c = document.createElement("canvas"); gl = c.getContext("webgl2") || c.getContext("webgl"); } catch (e) {}
  if (!gl || !holder){ root.classList.add("sem-3d"); return; }

  const renderer = new THREE.WebGLRenderer({ antialias: true, alpha: true, powerPreference: "high-performance" });
  renderer.setPixelRatio(Math.min(devicePixelRatio || 1, 1.75));
  renderer.outputColorSpace = THREE.SRGBColorSpace;
  renderer.toneMapping = THREE.ACESFilmicToneMapping;
  renderer.toneMappingExposure = 1.05;
  renderer.shadowMap.enabled = true;
  renderer.shadowMap.type = THREE.PCFSoftShadowMap;
  renderer.setClearColor(0x000000, 0);
  holder.appendChild(renderer.domElement);
  renderer.domElement.setAttribute("aria-hidden", "true");

  const scene = new THREE.Scene();
  const pmrem = new THREE.PMREMGenerator(renderer);
  scene.environment = pmrem.fromScene(new RoomEnvironment(), 0.04).texture;
  scene.environmentIntensity = 0.55;

  const camera = new THREE.PerspectiveCamera(24, 1, 0.01, 50);
  const giro = new THREE.Group();      // gira o tênis
  const salto = new THREE.Group();     // pulinho ao trocar de cor
  giro.add(salto); scene.add(giro);

  const key = new THREE.DirectionalLight(0xfff6ea, 2.6);
  key.castShadow = true;
  key.shadow.mapSize.set(1024, 1024);
  key.shadow.bias = -0.0004; key.shadow.radius = 6;
  const rim = new THREE.DirectionalLight(0xffcf8a, 3.2);
  const fill = new THREE.HemisphereLight(0xc9d6ff, 0x1a1410, 0.45);
  scene.add(key, rim, fill, key.target);

  let L = 0.3, centro = new THREE.Vector3(), topoPodio = 0, aro = null, brilho = null, malha = null;

  function montarPodio(){
    const R = L * 0.62, H = L * 0.14;
    const podio = new THREE.Mesh(
      new THREE.CylinderGeometry(R, R * 1.02, H, 96, 1),
      new THREE.MeshPhysicalMaterial({ color: 0x060607, roughness: 0.72, metalness: 0.05, clearcoat: 0.35, clearcoatRoughness: 0.5, envMapIntensity: 0.18 })
    );
    podio.position.y = topoPodio - H / 2;
    podio.receiveShadow = true;
    scene.add(podio);
    aro = new THREE.Mesh(
      new THREE.TorusGeometry(R * 1.003, L * 0.0042, 16, 160),
      new THREE.MeshStandardMaterial({ color: 0xd4ae68, emissive: 0xd4ae68, emissiveIntensity: 1.6, metalness: 1, roughness: 0.25 })
    );
    aro.rotation.x = Math.PI / 2; aro.position.y = topoPodio;
    scene.add(aro);
    const aro2 = aro.clone(); aro2.material = aro.material.clone(); aro2.material.emissiveIntensity = 0.45;
    aro2.position.y = topoPodio - H; aro2.scale.setScalar(1.02);
    scene.add(aro2);
    // brilho dourado no chão
    const cv = document.createElement("canvas"); cv.width = cv.height = 256;
    const g = cv.getContext("2d"); const gr = g.createRadialGradient(128, 128, 0, 128, 128, 128);
    gr.addColorStop(0, "rgba(214,180,126,0.55)"); gr.addColorStop(0.45, "rgba(214,180,126,0.16)"); gr.addColorStop(1, "rgba(214,180,126,0)");
    g.fillStyle = gr; g.fillRect(0, 0, 256, 256);
    const tx = new THREE.CanvasTexture(cv); tx.colorSpace = THREE.SRGBColorSpace;
    brilho = new THREE.Mesh(new THREE.PlaneGeometry(R * 4.2, R * 4.2), new THREE.MeshBasicMaterial({ map: tx, transparent: true, depthWrite: false, blending: THREE.AdditiveBlending }));
    brilho.rotation.x = -Math.PI / 2; brilho.position.y = topoPodio - H - 0.001;
    scene.add(brilho);
    // luzes no tamanho do tênis
    key.position.set(L * 2.2, L * 4.2, L * 3.0);
    key.target.position.set(0, topoPodio, 0);
    const sc = key.shadow.camera; sc.left = -L; sc.right = L; sc.top = L; sc.bottom = -L; sc.near = 0.01; sc.far = L * 12; sc.updateProjectionMatrix();
    rim.position.set(-L * 3, L * 2, -L * 4);
  }

  /* Enquadramentos do passeio: ângulo do tênis, distância, altura da câmera, deslocamento na tela */
  const K = [
    { p: 0.00, th: 35,  d: 1.16, el: 77, ty: 0.02 },
    { p: 0.30, th: 178, d: 0.84, el: 82, ty: 0.06 },
    { p: 0.57, th: 208, d: 0.60, el: 80, ty: 0.00 },
    { p: 0.86, th: 270, d: 0.64, el: 79, ty: 0.05 },
    { p: 1.00, th: 270, d: 0.64, el: 79, ty: 0.05 }
  ];
  function quadro(p){
    let i = 0; while (i < K.length - 2 && p > K[i + 1].p) i++;
    const a = K[i], b = K[i + 1], t = smooth(clamp((p - a.p) / (b.p - a.p), 0, 1));
    const o = {}; for (const k of ["th", "d", "el", "ty"]) o[k] = lerp(a[k], b[k], t); return o;
  }

  /* ---------- Arrastar para girar ---------- */
  let arrasto = 0, vel = 0, arrastando = false, ultimoX = 0, mexeu = false;
  const cv = renderer.domElement;
  cv.style.touchAction = "pan-y";
  cv.addEventListener("pointerdown", e => { arrastando = true; mexeu = true; ultimoX = e.clientX; vel = 0; cv.setPointerCapture && cv.setPointerCapture(e.pointerId); root.classList.add("arrastando"); });
  cv.addEventListener("pointermove", e => { if (!arrastando) return; const dx = e.clientX - ultimoX; ultimoX = e.clientX; arrasto += dx * 0.012; vel = dx * 0.012; });
  const soltar = () => { arrastando = false; root.classList.remove("arrastando"); };
  cv.addEventListener("pointerup", soltar); cv.addEventListener("pointercancel", soltar); cv.addEventListener("pointerleave", soltar);

  /* ---------- Tamanho ---------- */
  let largura = 1, altura = 1, mobile = false;
  function medir(){
    const r = holder.getBoundingClientRect();
    largura = Math.max(1, r.width); altura = Math.max(1, r.height);
    mobile = largura < 760;
    renderer.setSize(largura, altura, false);
    camera.aspect = largura / altura; camera.updateProjectionMatrix();
    desenhar(true);
  }
  new ResizeObserver(medir).observe(holder);

  /* ---------- Desenho ---------- */
  let visivel = true, rodando = false, t0 = performance.now(), salto0 = -1, rotSuave = null, tAnt = performance.now();
  function desenhar(forcar){
    if (!malha) return;
    const agora = performance.now(), dt = Math.min(0.1, (agora - tAnt) / 1000); tAnt = agora;
    const t = (agora - t0) / 1000;
    const q = quadro(prog);
    // balanço suave na abertura; some ao rolar
    const balanco = (reduced || window.__POSTER ? 0 : Math.sin(t * 0.55) * 18) * (1 - smooth(clamp(prog / 0.12, 0, 1)));
    if (!arrastando){ arrasto += vel; vel *= Math.pow(0.92, dt * 60); if (prog > 0.16) arrasto *= Math.pow(0.9, dt * 60); }
    const alvo = THREE.MathUtils.degToRad(-(q.th + balanco)) + arrasto;
    rotSuave = rotSuave === null ? alvo : lerp(rotSuave, alvo, forcar ? 1 : 1 - Math.exp(-dt * 7));
    giro.rotation.y = rotSuave;
    // pulinho ao trocar de cor
    if (salto0 >= 0){ const k = (performance.now() - salto0) / 520; if (k >= 1){ salto0 = -1; salto.position.y = 0; } else salto.position.y = Math.sin(k * Math.PI) * L * 0.07; }
    // câmera
    const ajuste = 1 / clamp(camera.aspect * (mobile ? 1.15 : 0.9), 0.35, 1);
    const dist = L * 2.6 * q.d * ajuste;
    const el = THREE.MathUtils.degToRad(q.el);
    const alvoCam = new THREE.Vector3(0, centro.y + L * q.ty, 0);
    camera.position.set(0, alvoCam.y + dist * Math.cos(el), dist * Math.sin(el));
    camera.lookAt(alvoCam);
    // desloca o tênis na tela (direita no computador, para cima no celular) durante o passeio
    const passeio = smooth(clamp((prog - 0.1) / 0.14, 0, 1));
    const meiaAltura = Math.tan(THREE.MathUtils.degToRad(camera.fov / 2)) * dist;
    const sx = mobile ? 0 : -0.2 * passeio * meiaAltura * camera.aspect * 2;
    const sy = (mobile ? (0.08 + 0.18 * passeio) : (0.08 - 0.08 * passeio)) * meiaAltura * 2;
    camera.setViewOffset(largura, altura, (sx / (meiaAltura * 2 * camera.aspect)) * largura, (sy / (meiaAltura * 2)) * altura, largura, altura);
    aro.material.emissiveIntensity = 1.4 + Math.sin(t * 1.6) * 0.25;
    renderer.render(scene, camera);
  }
  function loop(){
    if (!visivel || document.hidden){ rodando = false; return; }
    if (document.body.style.overflow === "hidden"){ requestAnimationFrame(loop); return; } // janela aberta por cima: pausa o desenho
    rodando = true; desenhar(false); requestAnimationFrame(loop);
  }
  function acordar(){ if (!rodando && visivel && !document.hidden){ rodando = true; requestAnimationFrame(loop); } }
  new IntersectionObserver(es => { visivel = es[0].isIntersecting; acordar(); }, { rootMargin: "100px" }).observe(sticky);
  document.addEventListener("visibilitychange", acordar);

  /* ---------- Carregar o tênis ---------- */
  const tl = new THREE.TextureLoader();
  function carregarCor(c){
    const cor = CORES[c];
    if (cor.map) return Promise.resolve(cor.map);
    return new Promise((ok, falha) => tl.load(cor.url, tx => { tx.flipY = false; tx.colorSpace = THREE.SRGBColorSpace; tx.anisotropy = 4; cor.map = tx; ok(tx); }, undefined, falha));
  }
  trocarCor = async c => {
    try { const tx = await carregarCor(c); if (corAtual !== c || !malha) return; malha.material.map = tx; malha.material.needsUpdate = true; salto0 = reduced ? -1 : performance.now(); acordar(); } catch (e) {}
  };

  new GLTFLoader().load("assets/3d/tenis-top4.glb", gltf => {
    const modelo = gltf.scene;
    modelo.traverse(o => { if (o.isMesh){ malha = o; o.castShadow = true; o.receiveShadow = true; if (o.material.map) o.material.map.anisotropy = 4; } });
    CORES.noite.map = malha.material.map;
    const caixa = new THREE.Box3().setFromObject(modelo);
    const tam = caixa.getSize(new THREE.Vector3()); const meio = caixa.getCenter(new THREE.Vector3());
    L = tam.x > tam.z ? tam.x : tam.z;
    modelo.position.set(-meio.x, -caixa.min.y, -meio.z);
    salto.add(modelo);
    topoPodio = 0; centro.set(0, tam.y * 0.5, 0);
    montarPodio();
    medir();
    if (corAtual !== "noite") trocarCor(corAtual);
    requestAnimationFrame(() => { desenhar(true); root.classList.add("pronto"); acordar(); });
    const pre = () => { carregarCor("gelo").catch(() => {}); carregarCor("grafite").catch(() => {}); };
    ("requestIdleCallback" in window) ? requestIdleCallback(pre, { timeout: 3000 }) : setTimeout(pre, 2000);
    window.__palco = { pronto: true };
  }, undefined, () => { root.classList.add("sem-3d"); });
}
