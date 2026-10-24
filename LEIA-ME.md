# TOP4 Inspirada em Você — loja + painel do lojista

Site da loja com estoque em tempo real e um painel protegido por e-mail e senha.
O banco de dados, o login e as fotos ficam no **Supabase** (plano gratuito atende bem uma loja desse porte).

## O que tem na pasta

| Arquivo | Para que serve |
|---|---|
| `index.html` | A loja (vitrine, sacola, reserva e pedido pelo WhatsApp) |
| `admin.html` | Painel do lojista (pedidos, estoque e produtos) |
| `config.js` | **Único arquivo que você precisa editar**: dados do Supabase, WhatsApp, Pix e parcelas |
| `assets/` | Logos, desenhos dos produtos, catálogo de demonstração e o tênis 3D (`assets/3d/`) |
| `supabase/1-estrutura.sql` | Cria tabelas, regras de segurança, reserva de estoque e fotos |
| `supabase/2-produtos-exemplo.sql` | (Opcional) 24 produtos de exemplo com estoque |

Sem o `config.js` preenchido, a loja abre em **modo demonstração**: mostra os produtos de exemplo, mas sem estoque e sem painel.

---

## Passo a passo (uns 15 minutos)

### 1. Criar o projeto no Supabase
1. Entre em **supabase.com**, crie uma conta e clique em **New project**.
2. Escolha um nome (ex.: `top4`), crie uma senha forte para o banco e, em região, prefira **South America (São Paulo)**.
3. Espere o projeto terminar de ser criado.

### 2. Criar o banco
1. No menu lateral, abra o **SQL Editor**.
2. Cole todo o conteúdo de `supabase/1-estrutura.sql` e clique em **Run**. Deve aparecer "Success".
3. (Opcional) Faça o mesmo com `supabase/2-produtos-exemplo.sql` para a loja já abrir com vitrine. Depois você edita ou apaga esses produtos pelo painel.

### 3. Criar o login do lojista
1. Vá em **Authentication → Users → Add user → Create new user**.
2. Informe o e-mail e a senha do dono da loja e marque **Auto Confirm User**.
3. Volte ao **SQL Editor** e rode, trocando pelo e-mail que você cadastrou:

```sql
insert into public.admins (user_id)
select id from auth.users where email = 'email-do-lojista@exemplo.com';
```

Só quem está nessa lista entra no painel. Para dar acesso a outra pessoa, crie o usuário dela e rode o mesmo comando com o e-mail dela.

4. Recomendado: em **Authentication → Sign In / Providers → Email**, desligue a opção que permite **novos cadastros** (o nome exato pode variar). Mesmo que fique ligada, ninguém de fora entra no painel sem estar na lista acima.

### 4. Ligar o site ao banco
1. Em **Project Settings → API** (ou **API Keys**), copie:
   - a **Project URL** (algo como `https://abcdefghijk.supabase.co`);
   - a chave **anon** ou **publishable**.
2. Abra `config.js` e cole nos campos `supabaseUrl` e `supabaseKey`.

> A chave anon/publishable foi feita para ficar no site, é pública mesmo. **Nunca** coloque a chave `service_role` / `secret` no `config.js`.

### 5. Colocar o site no ar
Qualquer hospedagem de site estático serve. A mais simples:
1. Entre em **app.netlify.com/drop**.
2. Arraste a pasta inteira (a que contém `index.html`).
3. Pronto: o Netlify dá um endereço. A loja fica em `/` e o painel em `/admin.html`.

Também funciona em Vercel, GitHub Pages, Hostinger etc. Dá para ligar um domínio próprio (ex.: `top4bequimao.com.br`) nas configurações da hospedagem.

### 6. Liberar o "Esqueci minha senha"
Em **Authentication → URL Configuration**:
- **Site URL**: o endereço da loja (ex.: `https://top4.netlify.app`);
- **Redirect URLs**: adicione o endereço do painel (ex.: `https://top4.netlify.app/admin.html`).

---

## Como funciona no dia a dia

1. O cliente escolhe o produto e o tamanho e toca em **Reservar e finalizar**.
2. O banco baixa o estoque de **todos os itens de uma vez**. Se faltar qualquer peça, nada é baixado e o cliente vê qual item esgotou. Duas pessoas nunca compram a mesma última unidade.
3. O cliente recebe um código (ex.: `T4-2310-AB12`) e o botão para mandar o pedido no WhatsApp da loja.
4. No painel, o pedido aparece na hora em **Pedidos → Aguardando**:
   - **Confirmar venda** quando o cliente pagar ou retirar;
   - **Cancelar** se ele desistir. As peças voltam para o estoque.
5. Em **Estoque**, digite a quantidade nova e ela salva sozinha.
6. Em **Produtos**, cadastre peças novas com foto, preço, preço "de" (para mostrar desconto), tamanhos e quantidade. A chave **Na loja / Oculto** tira um produto da vitrine sem apagar.

A vitrine atualiza sozinha: quando algo esgota, os clientes com a página aberta já veem "Esgotado".

### Reservas esquecidas (opcional)
Se o cliente reservar e sumir, a peça fica presa até você cancelar. Para cancelar sozinho reservas com mais de 48 horas:
1. Em **Database → Extensions**, ative **pg_cron**.
2. No **SQL Editor**, rode:

```sql
select cron.schedule('expirar-reservas', '0 * * * *', 'select public.expirar_reservas()');
```

---

## Ajustes rápidos no `config.js`
- `whatsapp`: número que recebe os pedidos (DDI + DDD + número, só dígitos).
- `descontoPix`: `0.05` = 5%.
- `maxParcelas` e `parcelaMinima`: regra do "ou 6x de R$ ... sem juros".
- `estoqueBaixo`: a partir de quantas peças a loja mostra "Últimas unidades".

## Bom saber
- **Fotos**: o painel reduz a foto antes de enviar (máx. 1600 px), então pode mandar direto do celular. Fundo branco ou neutro fica melhor na vitrine.
- **Plano gratuito do Supabase**: projetos sem nenhum acesso por cerca de uma semana são pausados; basta entrar no painel do Supabase para reativar. Uma loja com visitas não costuma pausar.
- **Segurança**: o cliente não consegue ler pedidos, alterar estoque ou preço. O valor do pedido é calculado no banco, não no navegador.

---

## Fotos e 3D do site

### Tênis em 3D (topo da página)
- O tênis do topo é um modelo 3D realista que o cliente gira com o dedo ou o mouse e troca de cor (Grafite, Rosé e Oceano).
- No celular aparece **"Ver no seu espaço"**, que coloca o tênis em tamanho real sobre a mesa (realidade aumentada).
- Arquivos: `assets/3d/tenis-3d.glb` (o modelo) e `assets/3d/poster-*.webp` (imagem que aparece enquanto o 3D carrega e serve de reserva).
- Licença: modelo "Materials Variants Shoe", © 2021 Shopify, [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/). A licença exige o crédito, que já está no rodapé do site. Não remova.
- É um tênis de demonstração, não um produto da TOP4. Para mostrar um produto da loja em 3D, é preciso um modelo `.glb` dele (há apps de celular que escaneiam o produto e geram o arquivo). Depois é só trocar o `tenis-3d.glb`.

### Fotos de campanha (Pexels)
As fotos das categorias, do futebol, da linha fitness, da galeria "Monte o seu estilo" e da loja vêm do [Pexels](https://www.pexels.com/license/), que permite uso comercial gratuito, sem crédito obrigatório (mesmo assim, o rodapé cita o Pexels).

| Onde aparece | Foto |
|---|---|
| Fundo do topo | [Jogo de futebol à noite](https://www.pexels.com/photo/men-on-football-pitch-at-night-16826138/) |
| Categoria Calçados | [Tênis brancos em movimento](https://www.pexels.com/photo/a-white-sneakers-6322602/) (cottonbro studio) |
| Categoria Feminino e galeria | [Mulher com look preto na rua](https://www.pexels.com/photo/fashionable-woman-posing-on-city-street-39742974/) |
| Categoria Masculino | [Homem de moletom no viaduto](https://www.pexels.com/photo/a-man-sitting-on-the-road-near-a-railing-and-concrete-barriers-5319571/) (cottonbro studio) |
| Categoria Futebol | [Campo iluminado visto de cima](https://www.pexels.com/photo/aerial-night-view-of-illuminated-soccer-field-32761355/) (Jose Parra) |
| Seção futebol | [Estádio à noite](https://www.pexels.com/photo/green-grass-football-field-during-night-time-4122451/) (Yanni Shams) |
| Linha fitness | [Mulher se alongando na academia](https://www.pexels.com/photo/woman-wearing-sports-bra-and-black-leggings-stretching-3931231/) (Andrea Piacquadio) |
| Galeria | [Tênis no deck](https://www.pexels.com/photo/a-person-wearing-white-sneakers-12317922/), [Bolas no gramado](https://www.pexels.com/photo/soccer-balls-on-green-grass-field-10452323/), [Tênis na calçada](https://www.pexels.com/photo/close-up-of-person-in-sneakers-sitting-on-street-18987346/), [Vitrine de loja](https://www.pexels.com/photo/clothes-in-store-behind-window-13532891/) |
| Nossa loja | [Interior de boutique](https://www.pexels.com/photo/black-clothes-hanging-on-clothes-metal-rack-5531709/) (Rachel Claire) |

- As fotos carregam direto do servidor do Pexels, já no tamanho certo para cada tela.
- **Melhor ainda**: troque pelas fotos reais da TOP4 (fachada, araras, clientes usando as peças). No `index.html`, procure o número da foto (ex.: `6322602`) e troque o endereço pelo da sua foto.
- Os **cards de produto** continuam usando a foto que o lojista envia pelo painel. Foto de banco de imagem não serve para produto, porque o cliente precisa ver exatamente a peça que vai comprar.
