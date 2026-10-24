/* =========================================================
   TOP4 — desenhos dos produtos e utilidades compartilhadas
   Usado pela loja e pelo painel. Quando o produto tem foto,
   a foto é mostrada; sem foto, aparece o desenho do "tipo".
   ========================================================= */
(function(){
let uid = 0;
const rgb = h => { const n = parseInt(String(h||"#777777").slice(1), 16); return [n>>16, (n>>8)&255, n&255]; };
const mix = (h,t,a) => { const x = rgb(h), y = rgb(t); return "#" + x.map((v,i)=>Math.round(v+(y[i]-v)*a).toString(16).padStart(2,"0")).join(""); };
const lighten = (h,a) => mix(h,"#ffffff",a), darken = (h,a) => mix(h,"#000000",a);
const lum = h => { const [r,g,b] = rgb(h); return (r*299+g*587+b*114)/1000; };
const safeColor = c => /^#[0-9a-fA-F]{6}$/.test(c||"") ? c : "#777777";

function star(cx,cy,r,fill){ let d=""; for(let i=0;i<10;i++){ const a=-Math.PI/2+i*Math.PI/5, rr=i%2?r*.45:r; d+=(i?"L":"M")+(cx+rr*Math.cos(a)).toFixed(1)+" "+(cy+rr*Math.sin(a)).toFixed(1); } return `<path d="${d}Z" fill="${fill}"/>`; }
function pent(cx,cy,r,rot){ let d=""; for(let i=0;i<5;i++){ const a=(rot+72*i)*Math.PI/180; d+=(i?"L":"M")+(cx+r*Math.cos(a)).toFixed(1)+" "+(cy+r*Math.sin(a)).toFixed(1); } return d+"Z"; }
function solid(d,c){
  const i=++uid, light=lum(c)>195;
  return `<defs><linearGradient id="g${i}" x1="0" y1="0" x2="1" y2="1"><stop offset="0" stop-color="${lighten(c,light?.35:.2)}"/><stop offset=".55" stop-color="${c}"/><stop offset="1" stop-color="${darken(c,light?.14:.32)}"/></linearGradient>
    <linearGradient id="s${i}" x1="0" y1="0" x2="1" y2="0"><stop offset="0" stop-color="#fff" stop-opacity="${light?.35:.16}"/><stop offset=".35" stop-color="#fff" stop-opacity="0"/><stop offset=".75" stop-color="#000" stop-opacity="0"/><stop offset="1" stop-color="#000" stop-opacity="${light?.1:.26}"/></linearGradient></defs>
    <path d="${d}" fill="url(#g${i})" ${light?'stroke="#000" stroke-opacity=".1" stroke-width="1"':""} stroke-linejoin="round"/>
    <path d="${d}" fill="url(#s${i})"/>`;
}
const stitch=(d,c)=>`<path d="${d}" fill="none" stroke="${lum(c)>140?"#000":"#fff"}" stroke-opacity="${lum(c)>140?.22:.3}" stroke-width=".9" stroke-dasharray="2.4 2" stroke-linecap="round"/>`;
const fold=(d,c)=>`<path d="${d}" fill="none" stroke="#000" stroke-opacity="${lum(c)>140?.07:.18}" stroke-width="2.4" stroke-linecap="round"/>`;

const DRAW = {
  tshirt(c,a){
    const B="M76 34 L88 28 Q100 44 112 28 L124 34 L168 58 L154 90 L140 84 L140 174 L60 174 L60 84 L46 90 L32 58 Z";
    return solid(B,c)+`<path d="M88 28 Q100 46 112 28" fill="none" stroke="${darken(c,.25)}" stroke-width="5" stroke-linecap="round"/>`
      +stitch("M86 33 Q100 50 114 33",c)+stitch("M38 61 L50 87",c)+stitch("M162 61 L150 87",c)+stitch("M62 168 L138 168",c)
      +fold("M80 100 Q86 132 80 162",c)+fold("M118 112 Q114 140 122 164",c)+star(122,64,6.5,a);
  },
  jersey(c,a){
    const B="M76 34 L88 28 Q100 44 112 28 L124 34 L168 58 L154 90 L140 84 L140 174 L60 174 L60 84 L46 90 L32 58 Z", i=++uid;
    return `<defs><clipPath id="j${i}"><path d="${B}"/></clipPath></defs>`+solid(B,c)
      +`<g clip-path="url(#j${i})" fill="${a}" opacity=".95">${[68,92,116].map(x=>`<rect x="${x}" y="40" width="14" height="140"/>`).join("")}</g>`
      +`<path d="M88 28 Q100 46 112 28" fill="none" stroke="#141414" stroke-width="5" stroke-linecap="round"/>`
      +`<path d="M32 58 L46 90 M168 58 L154 90" stroke="#141414" stroke-width="6"/>`
      +fold("M80 100 Q86 132 80 162",c)+fold("M120 110 Q116 140 124 164",c)+star(126,64,6,"#141414");
  },
  tank(c,a){
    const B="M80 30 Q100 54 120 30 L128 32 Q126 62 142 76 L142 174 L58 174 L58 76 Q74 62 72 32 Z";
    return solid(B,c)+`<path d="M80 30 Q100 54 120 30" fill="none" stroke="${darken(c,.22)}" stroke-width="4"/>`
      +stitch("M74 34 Q76 62 62 74",c)+stitch("M126 34 Q124 62 138 74",c)+stitch("M60 168 L140 168",c)+fold("M90 96 Q94 130 88 164",c)+star(116,96,6.5,a);
  },
  dress(c,a){
    const B="M84 24 L92 24 Q100 36 108 24 L116 24 Q114 50 124 64 L160 178 Q100 190 40 178 L76 64 Q86 50 84 24 Z";
    return solid(B,c)+`<path d="M77 66 Q100 74 123 66" fill="none" stroke="${a}" stroke-width="5" stroke-linecap="round"/>`
      +fold("M90 82 L78 172",c)+fold("M110 82 L124 174",c)+fold("M100 84 L101 180",c)+stitch("M44 174 Q100 185 156 174",c);
  },
  shorts(c,a){
    const B="M54 52 L146 52 L158 150 L110 158 L100 104 L90 158 L42 150 Z";
    return solid(B,c)+`<rect x="54" y="44" width="92" height="17" rx="4" fill="${darken(c,.28)}"/>`
      +`<path d="M95 61 Q93 78 86 82 M105 61 Q107 78 114 82" fill="none" stroke="${a}" stroke-width="2.4" stroke-linecap="round"/>`
      +stitch("M46 143 L90 150",c)+stitch("M154 143 L110 150",c)+`<path d="M152 100 L157 140" stroke="${a}" stroke-width="4" stroke-linecap="round"/>`+fold("M70 70 Q74 110 66 146",c);
  },
  legging(c,a){
    const B="M66 30 L134 30 L142 178 L110 178 L100 76 L90 178 L58 178 Z";
    return solid(B,c)+`<rect x="65" y="22" width="70" height="17" rx="4" fill="${darken(c,.25)}"/>`
      +`<path d="M64 110 L60 176 M136 110 L140 176" stroke="${a}" stroke-width="2.6" opacity=".9"/>`+stitch("M100 40 L100 76",c)+fold("M80 60 Q86 120 76 176",c)+fold("M122 70 Q118 126 126 176",c);
  },
  sneaker(c,a,studs){
    const light=lum(c)>170, U="M26 126 Q24 102 46 98 L82 90 Q94 70 110 62 L126 66 Q132 84 150 92 Q176 100 182 116 Q186 126 182 134 L28 134 Z";
    const soleC=light?"#1A1A1A":"#F1EFEA", i=++uid;
    let s=`<g transform="translate(0 6)">`+solid(U,c)
      +`<path d="M108 62 Q114 52 126 54 L130 66 Q120 63 110 66 Z" fill="${darken(c,.18)}"/>`
      +`<path d="M26 126 Q24 104 42 99 Q52 114 50 134 L28 134 Z" fill="${darken(c,.12)}"/>`+stitch("M44 103 Q52 116 50 132",c)
      +stitch("M138 95 Q170 102 180 118",c)
      +`<path d="M54 125 Q98 98 154 103 Q122 114 66 128 Z" fill="${a}"/>`
      +[[104,74],[98,82],[92,90]].map(([x,y])=>`<path d="M${x} ${y} L${x+14} ${y+8}" stroke="${light?"#2a2a2a":"#f4f3ef"}" stroke-width="3.2" stroke-linecap="round"/><circle cx="${x}" cy="${y}" r="1.6" fill="${darken(c,.4)}"/>`).join("")
      +`<defs><linearGradient id="sl${i}" x1="0" y1="0" x2="0" y2="1"><stop offset="0" stop-color="${lighten(soleC,.08)}"/><stop offset="1" stop-color="${darken(soleC,.12)}"/></linearGradient></defs>`
      +`<path d="M22 134 L186 134 Q192 136 189 146 Q186 154 174 154 L36 154 Q22 154 22 144 Z" fill="url(#sl${i})"/>`
      +`<path d="M23 148 L189 148 Q186 154 174 154 L36 154 Q24 154 23 148 Z" fill="${darken(soleC,.3)}"/>`
      +`<path d="M30 140 L182 140" stroke="${a}" stroke-width="1.6" opacity=".9"/>`;
    if(studs) s+=[40,60,118,140,164].map(x=>`<path d="M${x} 153 L${x+3} 165 L${x+12} 165 L${x+15} 153 Z" fill="${darken(soleC,.25)}"/>`).join("");
    return s+`</g>`;
  },
  cleat(c,a){ return DRAW.sneaker(c,a,true); },
  heel(c,a){
    const H="M24 152 Q24 142 40 140 L84 136 Q120 128 150 92 L164 78 Q174 72 174 86 L172 100 L168 168 L159 168 L156 110 Q126 146 90 156 L34 160 Q24 160 24 152 Z";
    return solid(H,c)+`<path d="M36 146 L84 141 Q120 133 152 96" fill="none" stroke="${lighten(c,.55)}" stroke-width="2.5" opacity=".55"/>`
      +`<path d="M157 166 L171 166" stroke="${a}" stroke-width="5" stroke-linecap="round"/>`
      +`<path d="M58 140 Q66 122 82 120" fill="none" stroke="${c}" stroke-width="5" stroke-linecap="round" opacity=".9"/>`;
  },
  ball(c){
    const i=++uid;
    let s=`<defs><clipPath id="b${i}"><circle cx="100" cy="100" r="70"/></clipPath>
      <radialGradient id="bs${i}" cx=".36" cy=".3" r=".8"><stop offset="0" stop-color="#fff" stop-opacity="0"/><stop offset=".6" stop-color="#000" stop-opacity="0"/><stop offset="1" stop-color="#000" stop-opacity=".42"/></radialGradient>
      <radialGradient id="bb${i}" cx=".35" cy=".3" r=".8"><stop offset="0" stop-color="#FFFFFF"/><stop offset="1" stop-color="#DAD8D2"/></radialGradient></defs>
      <circle cx="100" cy="100" r="70" fill="url(#bb${i})"/><g clip-path="url(#b${i})">`;
    s+=`<path d="${pent(100,100,21,-90)}" fill="${c}"/>`;
    for(let k=0;k<5;k++){ const ang=(-90+72*k)*Math.PI/180;
      s+=`<path d="M${(100+21*Math.cos(ang)).toFixed(1)} ${(100+21*Math.sin(ang)).toFixed(1)} L${(100+50*Math.cos(ang)).toFixed(1)} ${(100+50*Math.sin(ang)).toFixed(1)}" stroke="${c}" stroke-opacity=".55" stroke-width="1.6"/>`;
      s+=`<path d="${pent(100+70*Math.cos(ang),100+70*Math.sin(ang),20,-90+72*k+180)}" fill="${c}"/>`;
      const b=(-90+72*k+36)*Math.PI/180;
      s+=`<path d="M${(100+38*Math.cos(b)).toFixed(1)} ${(100+38*Math.sin(b)).toFixed(1)} L${(100+74*Math.cos(b)).toFixed(1)} ${(100+74*Math.sin(b)).toFixed(1)}" stroke="${c}" stroke-opacity=".3" stroke-width="1.4"/>`; }
    return s+`</g><circle cx="100" cy="100" r="70" fill="url(#bs${i})"/><ellipse cx="74" cy="66" rx="18" ry="10" transform="rotate(-35 74 66)" fill="#fff" opacity=".45"/>`;
  },
  cap(c,a){
    const D="M44 124 Q42 64 104 58 Q160 58 166 124 Z";
    return solid(D,c)+`<path d="M150 120 Q192 114 197 133 Q170 144 136 132 Z" fill="${darken(c,.18)}"/>`+stitch("M152 123 Q188 119 193 132",c)
      +`<path d="M104 58 Q88 90 90 124 M104 58 Q128 88 130 124" fill="none" stroke="#000" stroke-opacity=".14" stroke-width="1.6"/>`
      +`<circle cx="104" cy="59" r="5" fill="${darken(c,.2)}"/><path d="M44 124 L166 124" stroke="${darken(c,.25)}" stroke-width="5"/>`+star(74,96,9,a);
  },
  backpack(c,a){
    const B="M54 68 Q54 40 82 40 L118 40 Q146 40 146 68 L146 170 Q146 176 140 176 L60 176 Q54 176 54 170 Z";
    const P="M68 112 Q68 104 76 104 L124 104 Q132 104 132 112 L132 156 Q132 162 126 162 L74 162 Q68 162 68 156 Z";
    return `<path d="M84 44 Q84 24 100 24 Q116 24 116 44" fill="none" stroke="${darken(c,.25)}" stroke-width="7"/>`+solid(B,c)+solid(P,lighten(c,.06))
      +`<path d="M72 118 L128 118" stroke="${a}" stroke-width="2"/>`+stitch("M60 72 Q60 46 84 46 L116 46 Q140 46 140 72",c)
      +`<rect x="94" y="114" width="12" height="8" rx="2" fill="${a}"/>`+star(100,82,8,a);
  },
  bottle(c,a){
    const B="M72 70 Q72 52 90 52 L110 52 Q128 52 128 70 L128 168 Q128 178 118 178 L82 178 Q72 178 72 168 Z";
    return `<rect x="88" y="22" width="24" height="12" rx="4" fill="${a}"/><rect x="82" y="32" width="36" height="22" rx="7" fill="${a}"/>`
      +solid(B,c)+`<rect x="72" y="96" width="56" height="34" fill="${a}"/>`+star(100,113,9,c)
      +`<path d="M82 70 L82 166" stroke="#fff" stroke-width="5" stroke-linecap="round" opacity=".3"/>`;
  }
};

const TIPOS = [
  ["tshirt","Camiseta"],["jersey","Camisa de time"],["tank","Regata"],["dress","Vestido"],
  ["shorts","Short / bermuda"],["legging","Calça / legging"],["sneaker","Tênis"],["cleat","Chuteira"],
  ["heel","Salto / sandália"],["ball","Bola"],["cap","Boné"],["backpack","Mochila / bolsa"],["bottle","Garrafa / squeeze"]
];
const TAMANHOS = {
  roupa:["P","M","G","GG"],
  calcado:["37","38","39","40","41","42","43","44"],
  calcadoF:["33","34","35","36","37","38","39"],
  unico:["Único"]
};
function tamanhosPadrao(tipo, genero){
  if (tipo==="sneaker"||tipo==="cleat") return genero==="f" ? TAMANHOS.calcadoF : TAMANHOS.calcado;
  if (tipo==="heel") return TAMANHOS.calcadoF;
  if (["ball","cap","backpack","bottle"].includes(tipo)) return TAMANHOS.unico;
  return TAMANHOS.roupa;
}
const esc = s => String(s==null?"":s).replace(/[&<>"']/g, ch => ({"&":"&amp;","<":"&lt;",">":"&gt;",'"':"&quot;","'":"&#39;"}[ch]));

/* Desenho do produto (sem foto) */
function artSVG(tipo, c1, c2, label, opts){
  opts = opts || {};
  const fn = DRAW[tipo] || DRAW.tshirt;
  const i = ++uid;
  const shadow = opts.noShadow ? "" : `<defs><filter id="f${i}" x="-50%" y="-100%" width="200%" height="300%"><feGaussianBlur stdDeviation="5"/></filter></defs><ellipse cx="100" cy="184" rx="60" ry="6" fill="#000" opacity=".22" filter="url(#f${i})"/>`;
  return `<svg viewBox="-10 -14 220 230" role="img" aria-label="${esc(label||"")}">${shadow}${fn(safeColor(c1), safeColor(c2))}</svg>`;
}
/* Foto do produto, ou o desenho quando não houver foto */
function productArt(p, opts){
  if (p && p.foto_url && /^https:\/\//.test(p.foto_url)) {
    return `<img src="${esc(p.foto_url)}" alt="${esc(p.nome)}" loading="lazy" decoding="async">`;
  }
  return artSVG(p.tipo, p.cor1, p.cor2, p.nome, opts);
}

window.TOP4 = { DRAW, star, pent, mix, lighten, darken, lum, TIPOS, TAMANHOS, tamanhosPadrao, artSVG, productArt, esc };
})();
