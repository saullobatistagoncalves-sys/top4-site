/* =========================================================
   TOP4 — configuração da loja
   Preencha as duas primeiras linhas com os dados do seu projeto
   Supabase (Project Settings → API). Enquanto estiverem vazias,
   a loja abre em modo demonstração, sem estoque e sem painel.
   ========================================================= */
window.TOP4_CONFIG = {
  supabaseUrl: "",          // ex.: "https://abcdefghijk.supabase.co"
  supabaseKey: "",          // a chave "anon" / "publishable" (pode ficar pública)

  whatsapp: "5598983044291",  // DDI + DDD + número, só dígitos
  descontoPix: 0.05,          // 5%
  maxParcelas: 6,
  parcelaMinima: 30,          // R$ mínimo por parcela
  estoqueBaixo: 3             // a partir de quantas peças mostrar "últimas unidades"
};
