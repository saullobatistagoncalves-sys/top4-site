-- =====================================================================
--  TOP4 — produtos de exemplo (opcional)
--  Rode DEPOIS do 1-estrutura.sql para a loja já abrir com vitrine.
--  Preços, estoques e descrições são exemplos: edite ou apague pelo painel.
--  Rodar de novo não duplica: produtos com o mesmo nome são ignorados.
-- =====================================================================

with p as (
  insert into public.produtos (nome, descricao, genero, categorias, tipo, cor_nome, cor1, cor2, preco, preco_de, novo, tags, ordem, foto_url)
  select 'Tênis TOP4 Runner Noite', 'Malha leve e ventilada, faixas metalizadas em dourado e o logo da TOP4 no calcanhar. Entressola macia para o dia todo.', 'u', array['calcados','esportes']::text[], 'sneaker', 'Preto / Dourado', '#18181A', '#C29A5B', 249.90, 299.90, true, 'corrida academia caminhada runner tenis preto', 1, 'assets/produtos/runner-noite.webp'
  where not exists (select 1 from public.produtos where nome = 'Tênis TOP4 Runner Noite')
  returning id
)
insert into public.estoque (produto_id, tamanho, quantidade, ordem)
select p.id, t.tamanho, t.quantidade, t.ordem from p, (values ('37',2,0),('38',3,1),('39',4,2),('40',1,3),('41',3,4),('42',2,5),('43',0,6),('44',1,7)) as t(tamanho, quantidade, ordem);

with p as (
  insert into public.produtos (nome, descricao, genero, categorias, tipo, cor_nome, cor1, cor2, preco, preco_de, novo, tags, ordem, foto_url)
  select 'Chuteira Society Strike', 'Solado de travas baixas para grama sintética, com ótimo controle de bola.', 'u', array['calcados','esportes']::text[], 'cleat', 'Laranja', '#F05A28', '#1A1A1A', 189.90, 229.90, false, 'futebol society', 2, 'https://images.pexels.com/photos/33060541/pexels-photo-33060541.jpeg?auto=compress&cs=tinysrgb&w=1000'
  where not exists (select 1 from public.produtos where nome = 'Chuteira Society Strike')
  returning id
)
insert into public.estoque (produto_id, tamanho, quantidade, ordem)
select p.id, t.tamanho, t.quantidade, t.ordem from p, (values ('37',1,0),('38',2,1),('39',3,2),('40',3,3),('41',2,4),('42',1,5),('43',1,6),('44',0,7)) as t(tamanho, quantidade, ordem);

with p as (
  insert into public.produtos (nome, descricao, genero, categorias, tipo, cor_nome, cor1, cor2, preco, preco_de, novo, tags, ordem, foto_url)
  select 'Camiseta Dry Fit Performance', 'Tecido leve que seca rápido. Ideal para treino e corrida.', 'm', array['esportes']::text[], 'tshirt', 'Preto', '#1A1A1B', '#C29A5B', 79.90, 99.90, false, 'academia corrida treino', 3, 'https://images.pexels.com/photos/16069737/pexels-photo-16069737.jpeg?auto=compress&cs=tinysrgb&w=1000'
  where not exists (select 1 from public.produtos where nome = 'Camiseta Dry Fit Performance')
  returning id
)
insert into public.estoque (produto_id, tamanho, quantidade, ordem)
select p.id, t.tamanho, t.quantidade, t.ordem from p, (values ('P',1,0),('M',1,1),('G',1,2),('GG',0,3)) as t(tamanho, quantidade, ordem);

with p as (
  insert into public.produtos (nome, descricao, genero, categorias, tipo, cor_nome, cor1, cor2, preco, preco_de, novo, tags, ordem, foto_url)
  select 'Vestido Midi Canelado', 'Malha canelada com caimento ajustado. Combina com tênis ou salto.', 'f', '{}'::text[], 'dress', 'Preto', '#151517', '#C29A5B', 129.90, 159.90, true, 'moda casual festa', 4, 'https://images.pexels.com/photos/39000400/pexels-photo-39000400.jpeg?auto=compress&cs=tinysrgb&w=1000'
  where not exists (select 1 from public.produtos where nome = 'Vestido Midi Canelado')
  returning id
)
insert into public.estoque (produto_id, tamanho, quantidade, ordem)
select p.id, t.tamanho, t.quantidade, t.ordem from p, (values ('P',2,0),('M',3,1),('G',2,2),('GG',1,3)) as t(tamanho, quantidade, ordem);

with p as (
  insert into public.produtos (nome, descricao, genero, categorias, tipo, cor_nome, cor1, cor2, preco, preco_de, novo, tags, ordem, foto_url)
  select 'Legging Cintura Alta', 'Compressão na medida, não fica transparente e modela a cintura.', 'f', array['esportes']::text[], 'legging', 'Preto', '#1C1C1F', '#C29A5B', 89.90, 109.90, false, 'academia fitness treino', 5, 'https://images.pexels.com/photos/31443911/pexels-photo-31443911.jpeg?auto=compress&cs=tinysrgb&w=1000'
  where not exists (select 1 from public.produtos where nome = 'Legging Cintura Alta')
  returning id
)
insert into public.estoque (produto_id, tamanho, quantidade, ordem)
select p.id, t.tamanho, t.quantidade, t.ordem from p, (values ('P',3,0),('M',4,1),('G',2,2),('GG',1,3)) as t(tamanho, quantidade, ordem);

with p as (
  insert into public.produtos (nome, descricao, genero, categorias, tipo, cor_nome, cor1, cor2, preco, preco_de, novo, tags, ordem, foto_url)
  select 'Bola de Futebol Campo', 'Gomos termossoldados, tamanho oficial, para jogos e treinos.', 'u', array['esportes']::text[], 'ball', 'Branco / Preto', '#161616', '#161616', 99.90, 129.90, false, 'futebol campo', 6, 'https://images.pexels.com/photos/12039815/pexels-photo-12039815.jpeg?auto=compress&cs=tinysrgb&w=1000'
  where not exists (select 1 from public.produtos where nome = 'Bola de Futebol Campo')
  returning id
)
insert into public.estoque (produto_id, tamanho, quantidade, ordem)
select p.id, t.tamanho, t.quantidade, t.ordem from p, (values ('Único',6,0)) as t(tamanho, quantidade, ordem);

with p as (
  insert into public.produtos (nome, descricao, genero, categorias, tipo, cor_nome, cor1, cor2, preco, preco_de, novo, tags, ordem, foto_url)
  select 'Tênis TOP4 Runner Gelo', 'Branco que combina com tudo, com faixas em dourado e cadarço preto. Leve para usar do trabalho ao fim de semana.', 'm', array['calcados']::text[], 'sneaker', 'Branco / Dourado', '#ECEBE7', '#C29A5B', 249.90, null, true, 'casual dia a dia runner tenis branco', 7, 'assets/produtos/runner-gelo.webp'
  where not exists (select 1 from public.produtos where nome = 'Tênis TOP4 Runner Gelo')
  returning id
)
insert into public.estoque (produto_id, tamanho, quantidade, ordem)
select p.id, t.tamanho, t.quantidade, t.ordem from p, (values ('37',0,0),('38',1,1),('39',2,2),('40',2,3),('41',3,4),('42',2,5),('43',1,6),('44',1,7)) as t(tamanho, quantidade, ordem);

with p as (
  insert into public.produtos (nome, descricao, genero, categorias, tipo, cor_nome, cor1, cor2, preco, preco_de, novo, tags, ordem, foto_url)
  select 'Camiseta Listrada', 'Algodão macio com listras horizontais. Combina com jeans e tênis.', 'm', '{}'::text[], 'jersey', 'Vermelho / Branco', '#A51C2C', '#F2F0EA', 119.90, 149.90, false, 'casual listrada moda', 8, 'https://images.pexels.com/photos/17086274/pexels-photo-17086274.jpeg?auto=compress&cs=tinysrgb&w=1000'
  where not exists (select 1 from public.produtos where nome = 'Camiseta Listrada')
  returning id
)
insert into public.estoque (produto_id, tamanho, quantidade, ordem)
select p.id, t.tamanho, t.quantidade, t.ordem from p, (values ('P',2,0),('M',4,1),('G',3,2),('GG',2,3)) as t(tamanho, quantidade, ordem);

with p as (
  insert into public.produtos (nome, descricao, genero, categorias, tipo, cor_nome, cor1, cor2, preco, preco_de, novo, tags, ordem, foto_url)
  select 'Scarpin Salto Fino', 'Bico fino e salto de 9 cm, acabamento verniz.', 'f', array['calcados']::text[], 'heel', 'Preto verniz', '#141414', '#C29A5B', 149.90, null, true, 'festa salto social', 9, 'https://images.pexels.com/photos/10528003/pexels-photo-10528003.jpeg?auto=compress&cs=tinysrgb&w=1000'
  where not exists (select 1 from public.produtos where nome = 'Scarpin Salto Fino')
  returning id
)
insert into public.estoque (produto_id, tamanho, quantidade, ordem)
select p.id, t.tamanho, t.quantidade, t.ordem from p, (values ('33',0,0),('34',1,1),('35',0,2),('36',1,3),('37',0,4),('38',0,5),('39',0,6)) as t(tamanho, quantidade, ordem);

with p as (
  insert into public.produtos (nome, descricao, genero, categorias, tipo, cor_nome, cor1, cor2, preco, preco_de, novo, tags, ordem, foto_url)
  select 'Short Esportivo 2 em 1', 'Bermuda com forro em compressão e bolso para celular.', 'm', array['esportes']::text[], 'shorts', 'Grafite', '#3A3B40', '#C29A5B', 59.90, null, false, 'academia corrida futebol', 10, 'https://images.pexels.com/photos/25315942/pexels-photo-25315942.jpeg?auto=compress&cs=tinysrgb&w=1000'
  where not exists (select 1 from public.produtos where nome = 'Short Esportivo 2 em 1')
  returning id
)
insert into public.estoque (produto_id, tamanho, quantidade, ordem)
select p.id, t.tamanho, t.quantidade, t.ordem from p, (values ('P',3,0),('M',5,1),('G',4,2),('GG',2,3)) as t(tamanho, quantidade, ordem);

with p as (
  insert into public.produtos (nome, descricao, genero, categorias, tipo, cor_nome, cor1, cor2, preco, preco_de, novo, tags, ordem, foto_url)
  select 'Tênis TOP4 Runner Grafite', 'Grafite com solado caramelo e detalhes dourados. Amortecimento macio para caminhada e academia.', 'f', array['calcados','esportes']::text[], 'sneaker', 'Grafite / Caramelo', '#5A5B60', '#A97D52', 229.90, 259.90, false, 'academia caminhada corrida runner tenis cinza', 11, 'assets/produtos/runner-grafite.webp'
  where not exists (select 1 from public.produtos where nome = 'Tênis TOP4 Runner Grafite')
  returning id
)
insert into public.estoque (produto_id, tamanho, quantidade, ordem)
select p.id, t.tamanho, t.quantidade, t.ordem from p, (values ('33',1,0),('34',2,1),('35',3,2),('36',2,3),('37',2,4),('38',1,5),('39',0,6)) as t(tamanho, quantidade, ordem);

with p as (
  insert into public.produtos (nome, descricao, genero, categorias, tipo, cor_nome, cor1, cor2, preco, preco_de, novo, tags, ordem, foto_url)
  select 'Regata Fitness Feminina', 'Costas nadador e tecido com toque gelado.', 'f', array['esportes']::text[], 'tank', 'Rosa', '#D9668F', '#F2F0EA', 49.90, null, false, 'academia fitness', 12, 'https://images.pexels.com/photos/17881678/pexels-photo-17881678.jpeg?auto=compress&cs=tinysrgb&w=1000'
  where not exists (select 1 from public.produtos where nome = 'Regata Fitness Feminina')
  returning id
)
insert into public.estoque (produto_id, tamanho, quantidade, ordem)
select p.id, t.tamanho, t.quantidade, t.ordem from p, (values ('P',2,0),('M',3,1),('G',2,2),('GG',1,3)) as t(tamanho, quantidade, ordem);

with p as (
  insert into public.produtos (nome, descricao, genero, categorias, tipo, cor_nome, cor1, cor2, preco, preco_de, novo, tags, ordem, foto_url)
  select 'Chuteira Campo Pro', 'Travas altas para grama natural e cabedal sintético macio.', 'u', array['calcados','esportes']::text[], 'cleat', 'Azul royal', '#2A4FA8', '#F2F0EA', 259.90, null, false, 'futebol campo', 13, null
  where not exists (select 1 from public.produtos where nome = 'Chuteira Campo Pro')
  returning id
)
insert into public.estoque (produto_id, tamanho, quantidade, ordem)
select p.id, t.tamanho, t.quantidade, t.ordem from p, (values ('37',0,0),('38',1,1),('39',2,2),('40',2,3),('41',1,4),('42',1,5),('43',0,6),('44',0,7)) as t(tamanho, quantidade, ordem);

with p as (
  insert into public.produtos (nome, descricao, genero, categorias, tipo, cor_nome, cor1, cor2, preco, preco_de, novo, tags, ordem, foto_url)
  select 'Mochila Esportiva 25L', 'Compartimento para notebook, bolso térmico e alças acolchoadas.', 'u', array['acessorios']::text[], 'backpack', 'Preto', '#2A2A2C', '#C29A5B', 149.90, 179.90, false, 'escola academia viagem', 14, 'https://images.pexels.com/photos/17491913/pexels-photo-17491913.jpeg?auto=compress&cs=tinysrgb&w=1000'
  where not exists (select 1 from public.produtos where nome = 'Mochila Esportiva 25L')
  returning id
)
insert into public.estoque (produto_id, tamanho, quantidade, ordem)
select p.id, t.tamanho, t.quantidade, t.ordem from p, (values ('Único',4,0)) as t(tamanho, quantidade, ordem);

with p as (
  insert into public.produtos (nome, descricao, genero, categorias, tipo, cor_nome, cor1, cor2, preco, preco_de, novo, tags, ordem, foto_url)
  select 'Boné Aba Curva', 'Ajuste traseiro e aba curva estruturada.', 'u', array['acessorios']::text[], 'cap', 'Preto', '#171717', '#C29A5B', 59.90, null, false, 'casual', 15, 'https://images.pexels.com/photos/16166738/pexels-photo-16166738.jpeg?auto=compress&cs=tinysrgb&w=1000'
  where not exists (select 1 from public.produtos where nome = 'Boné Aba Curva')
  returning id
)
insert into public.estoque (produto_id, tamanho, quantidade, ordem)
select p.id, t.tamanho, t.quantidade, t.ordem from p, (values ('Único',8,0)) as t(tamanho, quantidade, ordem);

with p as (
  insert into public.produtos (nome, descricao, genero, categorias, tipo, cor_nome, cor1, cor2, preco, preco_de, novo, tags, ordem, foto_url)
  select 'Calça Jogger Cargo', 'Modelagem jogger com bolsos cargo e punho na barra. Leve e confortável.', 'm', '{}'::text[], 'legging', 'Off-white', '#ECE9E1', '#141414', 119.90, 139.90, false, 'casual cargo jogger moda', 16, 'https://images.pexels.com/photos/39457505/pexels-photo-39457505.jpeg?auto=compress&cs=tinysrgb&w=1000'
  where not exists (select 1 from public.produtos where nome = 'Calça Jogger Cargo')
  returning id
)
insert into public.estoque (produto_id, tamanho, quantidade, ordem)
select p.id, t.tamanho, t.quantidade, t.ordem from p, (values ('P',2,0),('M',3,1),('G',3,2),('GG',1,3)) as t(tamanho, quantidade, ordem);

with p as (
  insert into public.produtos (nome, descricao, genero, categorias, tipo, cor_nome, cor1, cor2, preco, preco_de, novo, tags, ordem, foto_url)
  select 'Sandália de Tiras', 'Tiras finas e salto alto de 9 cm. Para festas e ocasiões especiais.', 'f', array['calcados']::text[], 'heel', 'Vermelho', '#C4202E', '#EDE9E1', 139.90, 169.90, false, 'festa salto', 17, 'https://images.pexels.com/photos/15792209/pexels-photo-15792209.jpeg?auto=compress&cs=tinysrgb&w=1000'
  where not exists (select 1 from public.produtos where nome = 'Sandália de Tiras')
  returning id
)
insert into public.estoque (produto_id, tamanho, quantidade, ordem)
select p.id, t.tamanho, t.quantidade, t.ordem from p, (values ('33',0,0),('34',0,1),('35',0,2),('36',0,3),('37',0,4),('38',0,5),('39',0,6)) as t(tamanho, quantidade, ordem);

with p as (
  insert into public.produtos (nome, descricao, genero, categorias, tipo, cor_nome, cor1, cor2, preco, preco_de, novo, tags, ordem, foto_url)
  select 'Camiseta Oversized TOP4', 'Modelagem ampla em algodão grosso. A cara da TOP4.', 'm', '{}'::text[], 'tshirt', 'Branco', '#E6E3DB', '#141414', 89.90, null, true, 'casual moda', 18, 'https://images.pexels.com/photos/18257675/pexels-photo-18257675.jpeg?auto=compress&cs=tinysrgb&w=1000'
  where not exists (select 1 from public.produtos where nome = 'Camiseta Oversized TOP4')
  returning id
)
insert into public.estoque (produto_id, tamanho, quantidade, ordem)
select p.id, t.tamanho, t.quantidade, t.ordem from p, (values ('P',4,0),('M',6,1),('G',5,2),('GG',3,3)) as t(tamanho, quantidade, ordem);

with p as (
  insert into public.produtos (nome, descricao, genero, categorias, tipo, cor_nome, cor1, cor2, preco, preco_de, novo, tags, ordem, foto_url)
  select 'Short Feminino Fitness', 'Cós alto, tecido que não marca e não sobe no agachamento.', 'f', array['esportes']::text[], 'shorts', 'Pink', '#E2397C', '#F2F0EA', 54.90, null, false, 'academia fitness', 19, 'https://images.pexels.com/photos/28774756/pexels-photo-28774756.jpeg?auto=compress&cs=tinysrgb&w=1000'
  where not exists (select 1 from public.produtos where nome = 'Short Feminino Fitness')
  returning id
)
insert into public.estoque (produto_id, tamanho, quantidade, ordem)
select p.id, t.tamanho, t.quantidade, t.ordem from p, (values ('P',2,0),('M',3,1),('G',2,2),('GG',1,3)) as t(tamanho, quantidade, ordem);

with p as (
  insert into public.produtos (nome, descricao, genero, categorias, tipo, cor_nome, cor1, cor2, preco, preco_de, novo, tags, ordem, foto_url)
  select 'Bola Society Treino', 'Quique controlado para grama sintética.', 'u', array['esportes']::text[], 'ball', 'Caramelo', '#B9875A', '#B9875A', 79.90, null, false, 'futebol society', 20, 'https://images.pexels.com/photos/38275739/pexels-photo-38275739.jpeg?auto=compress&cs=tinysrgb&w=1000'
  where not exists (select 1 from public.produtos where nome = 'Bola Society Treino')
  returning id
)
insert into public.estoque (produto_id, tamanho, quantidade, ordem)
select p.id, t.tamanho, t.quantidade, t.ordem from p, (values ('Único',2,0)) as t(tamanho, quantidade, ordem);

with p as (
  insert into public.produtos (nome, descricao, genero, categorias, tipo, cor_nome, cor1, cor2, preco, preco_de, novo, tags, ordem, foto_url)
  select 'Squeeze Térmico 750ml', 'Mantém a água gelada por horas. Bico com trava.', 'u', array['acessorios','esportes']::text[], 'bottle', 'Branco', '#EDEDEA', '#9A9A9A', 34.90, null, false, 'academia treino', 21, 'https://images.pexels.com/photos/5274793/pexels-photo-5274793.jpeg?auto=compress&cs=tinysrgb&w=1000'
  where not exists (select 1 from public.produtos where nome = 'Squeeze Térmico 750ml')
  returning id
)
insert into public.estoque (produto_id, tamanho, quantidade, ordem)
select p.id, t.tamanho, t.quantidade, t.ordem from p, (values ('Único',12,0)) as t(tamanho, quantidade, ordem);

with p as (
  insert into public.produtos (nome, descricao, genero, categorias, tipo, cor_nome, cor1, cor2, preco, preco_de, novo, tags, ordem, foto_url)
  select 'Vestido Leve Estampado', 'Viscose fresquinha, perfeita para o calor do Maranhão.', 'f', '{}'::text[], 'dress', 'Floral', '#C9874A', '#F6EBDA', 109.90, null, false, 'moda casual praia', 22, 'https://images.pexels.com/photos/29277214/pexels-photo-29277214.jpeg?auto=compress&cs=tinysrgb&w=1000'
  where not exists (select 1 from public.produtos where nome = 'Vestido Leve Estampado')
  returning id
)
insert into public.estoque (produto_id, tamanho, quantidade, ordem)
select p.id, t.tamanho, t.quantidade, t.ordem from p, (values ('P',1,0),('M',2,1),('G',2,2),('GG',1,3)) as t(tamanho, quantidade, ordem);

with p as (
  insert into public.produtos (nome, descricao, genero, categorias, tipo, cor_nome, cor1, cor2, preco, preco_de, novo, tags, ordem, foto_url)
  select 'Boné Trucker', 'Frente estruturada e tela traseira respirável.', 'u', array['acessorios']::text[], 'cap', 'Branco / Preto', '#E3E0D8', '#141414', 54.90, 64.90, false, 'casual', 23, 'https://images.pexels.com/photos/9558758/pexels-photo-9558758.jpeg?auto=compress&cs=tinysrgb&w=1000'
  where not exists (select 1 from public.produtos where nome = 'Boné Trucker')
  returning id
)
insert into public.estoque (produto_id, tamanho, quantidade, ordem)
select p.id, t.tamanho, t.quantidade, t.ordem from p, (values ('Único',0,0)) as t(tamanho, quantidade, ordem);

with p as (
  insert into public.produtos (nome, descricao, genero, categorias, tipo, cor_nome, cor1, cor2, preco, preco_de, novo, tags, ordem, foto_url)
  select 'Regata Masculina Treino', 'Cavas amplas para liberdade total nos treinos.', 'm', array['esportes']::text[], 'tank', 'Preto', '#151517', '#C29A5B', 44.90, null, false, 'academia treino', 24, 'https://images.pexels.com/photos/32928799/pexels-photo-32928799.jpeg?auto=compress&cs=tinysrgb&w=1000'
  where not exists (select 1 from public.produtos where nome = 'Regata Masculina Treino')
  returning id
)
insert into public.estoque (produto_id, tamanho, quantidade, ordem)
select p.id, t.tamanho, t.quantidade, t.ordem from p, (values ('P',3,0),('M',4,1),('G',3,2),('GG',2,3)) as t(tamanho, quantidade, ordem);
