-- =====================================================================
--  TOP4 — produtos de exemplo (opcional)
--  Rode DEPOIS do 1-estrutura.sql para a loja já abrir com vitrine.
--  Preços, estoques e descrições são exemplos: edite ou apague pelo painel.
--  Rodar de novo não duplica: produtos com o mesmo nome são ignorados.
-- =====================================================================

with p as (
  insert into public.produtos (nome, descricao, genero, categorias, tipo, cor_nome, cor1, cor2, preco, preco_de, novo, tags, ordem)
  select 'Tênis Runner Leve', 'Cabedal em tela respirável e entressola macia para treinos e o dia a dia.', 'u', array['calcados','esportes']::text[], 'sneaker', 'Off-white / Dourado', '#EDECE8', '#C29A5B', 249.90, 299.90, false, 'corrida academia caminhada', 1
  where not exists (select 1 from public.produtos where nome = 'Tênis Runner Leve')
  returning id
)
insert into public.estoque (produto_id, tamanho, quantidade, ordem)
select p.id, t.tamanho, t.quantidade, t.ordem from p, (values ('37',2,0),('38',3,1),('39',4,2),('40',1,3),('41',3,4),('42',2,5),('43',0,6),('44',1,7)) as t(tamanho, quantidade, ordem);

with p as (
  insert into public.produtos (nome, descricao, genero, categorias, tipo, cor_nome, cor1, cor2, preco, preco_de, novo, tags, ordem)
  select 'Chuteira Society Strike', 'Solado de travas baixas para grama sintética, com ótimo controle de bola.', 'u', array['calcados','esportes']::text[], 'cleat', 'Dourado / Preto', '#D6AE5E', '#141414', 189.90, 229.90, false, 'futebol society', 2
  where not exists (select 1 from public.produtos where nome = 'Chuteira Society Strike')
  returning id
)
insert into public.estoque (produto_id, tamanho, quantidade, ordem)
select p.id, t.tamanho, t.quantidade, t.ordem from p, (values ('37',1,0),('38',2,1),('39',3,2),('40',3,3),('41',2,4),('42',1,5),('43',1,6),('44',0,7)) as t(tamanho, quantidade, ordem);

with p as (
  insert into public.produtos (nome, descricao, genero, categorias, tipo, cor_nome, cor1, cor2, preco, preco_de, novo, tags, ordem)
  select 'Camiseta Dry Fit Performance', 'Tecido leve que seca rápido. Ideal para treino e corrida.', 'm', array['esportes']::text[], 'tshirt', 'Preto', '#1A1A1B', '#C29A5B', 79.90, 99.90, false, 'academia corrida treino', 3
  where not exists (select 1 from public.produtos where nome = 'Camiseta Dry Fit Performance')
  returning id
)
insert into public.estoque (produto_id, tamanho, quantidade, ordem)
select p.id, t.tamanho, t.quantidade, t.ordem from p, (values ('P',1,0),('M',1,1),('G',1,2),('GG',0,3)) as t(tamanho, quantidade, ordem);

with p as (
  insert into public.produtos (nome, descricao, genero, categorias, tipo, cor_nome, cor1, cor2, preco, preco_de, novo, tags, ordem)
  select 'Vestido Midi Canelado', 'Malha canelada com caimento ajustado. Combina com tênis ou salto.', 'f', '{}'::text[], 'dress', 'Grafite', '#2B2A2C', '#C29A5B', 129.90, 159.90, true, 'moda casual festa', 4
  where not exists (select 1 from public.produtos where nome = 'Vestido Midi Canelado')
  returning id
)
insert into public.estoque (produto_id, tamanho, quantidade, ordem)
select p.id, t.tamanho, t.quantidade, t.ordem from p, (values ('P',2,0),('M',3,1),('G',2,2),('GG',1,3)) as t(tamanho, quantidade, ordem);

with p as (
  insert into public.produtos (nome, descricao, genero, categorias, tipo, cor_nome, cor1, cor2, preco, preco_de, novo, tags, ordem)
  select 'Legging Cintura Alta', 'Compressão na medida, não fica transparente e modela a cintura.', 'f', array['esportes']::text[], 'legging', 'Azul-marinho', '#26344A', '#C29A5B', 89.90, 109.90, false, 'academia fitness treino', 5
  where not exists (select 1 from public.produtos where nome = 'Legging Cintura Alta')
  returning id
)
insert into public.estoque (produto_id, tamanho, quantidade, ordem)
select p.id, t.tamanho, t.quantidade, t.ordem from p, (values ('P',3,0),('M',4,1),('G',2,2),('GG',1,3)) as t(tamanho, quantidade, ordem);

with p as (
  insert into public.produtos (nome, descricao, genero, categorias, tipo, cor_nome, cor1, cor2, preco, preco_de, novo, tags, ordem)
  select 'Bola de Futebol Campo', 'Gomos termossoldados, tamanho oficial, para jogos e treinos.', 'u', array['esportes']::text[], 'ball', 'Branco / Preto', '#161616', '#161616', 99.90, 129.90, false, 'futebol campo', 6
  where not exists (select 1 from public.produtos where nome = 'Bola de Futebol Campo')
  returning id
)
insert into public.estoque (produto_id, tamanho, quantidade, ordem)
select p.id, t.tamanho, t.quantidade, t.ordem from p, (values ('Único',6,0)) as t(tamanho, quantidade, ordem);

with p as (
  insert into public.produtos (nome, descricao, genero, categorias, tipo, cor_nome, cor1, cor2, preco, preco_de, novo, tags, ordem)
  select 'Tênis Casual Street', 'Visual urbano com conforto para usar o dia inteiro.', 'm', array['calcados']::text[], 'sneaker', 'Preto / Dourado', '#1C1C1D', '#C29A5B', 219.90, null, true, 'casual dia a dia', 7
  where not exists (select 1 from public.produtos where nome = 'Tênis Casual Street')
  returning id
)
insert into public.estoque (produto_id, tamanho, quantidade, ordem)
select p.id, t.tamanho, t.quantidade, t.ordem from p, (values ('37',0,0),('38',1,1),('39',2,2),('40',2,3),('41',3,4),('42',2,5),('43',1,6),('44',1,7)) as t(tamanho, quantidade, ordem);

with p as (
  insert into public.produtos (nome, descricao, genero, categorias, tipo, cor_nome, cor1, cor2, preco, preco_de, novo, tags, ordem)
  select 'Camisa de Futebol Listrada', 'Tecido de jogo com listras verticais e gola careca.', 'm', array['esportes']::text[], 'jersey', 'Vermelho / Branco', '#A51C2C', '#F2F0EA', 119.90, 149.90, false, 'futebol time torcida', 8
  where not exists (select 1 from public.produtos where nome = 'Camisa de Futebol Listrada')
  returning id
)
insert into public.estoque (produto_id, tamanho, quantidade, ordem)
select p.id, t.tamanho, t.quantidade, t.ordem from p, (values ('P',2,0),('M',4,1),('G',3,2),('GG',2,3)) as t(tamanho, quantidade, ordem);

with p as (
  insert into public.produtos (nome, descricao, genero, categorias, tipo, cor_nome, cor1, cor2, preco, preco_de, novo, tags, ordem)
  select 'Scarpin Salto Fino', 'Bico fino e salto de 9 cm, acabamento verniz.', 'f', array['calcados']::text[], 'heel', 'Preto verniz', '#141414', '#C29A5B', 149.90, null, true, 'festa salto social', 9
  where not exists (select 1 from public.produtos where nome = 'Scarpin Salto Fino')
  returning id
)
insert into public.estoque (produto_id, tamanho, quantidade, ordem)
select p.id, t.tamanho, t.quantidade, t.ordem from p, (values ('33',0,0),('34',1,1),('35',0,2),('36',1,3),('37',0,4),('38',0,5),('39',0,6)) as t(tamanho, quantidade, ordem);

with p as (
  insert into public.produtos (nome, descricao, genero, categorias, tipo, cor_nome, cor1, cor2, preco, preco_de, novo, tags, ordem)
  select 'Short Esportivo 2 em 1', 'Bermuda com forro em compressão e bolso para celular.', 'm', array['esportes']::text[], 'shorts', 'Azul petróleo', '#22303F', '#C29A5B', 59.90, null, false, 'academia corrida futebol', 10
  where not exists (select 1 from public.produtos where nome = 'Short Esportivo 2 em 1')
  returning id
)
insert into public.estoque (produto_id, tamanho, quantidade, ordem)
select p.id, t.tamanho, t.quantidade, t.ordem from p, (values ('P',3,0),('M',5,1),('G',4,2),('GG',2,3)) as t(tamanho, quantidade, ordem);

with p as (
  insert into public.produtos (nome, descricao, genero, categorias, tipo, cor_nome, cor1, cor2, preco, preco_de, novo, tags, ordem)
  select 'Tênis Feminino Cloud', 'Amortecimento extra e palmilha macia. Leve como uma nuvem.', 'f', array['calcados','esportes']::text[], 'sneaker', 'Rosa quartzo', '#EBCFD3', '#3A3537', 229.90, 259.90, false, 'academia caminhada corrida', 11
  where not exists (select 1 from public.produtos where nome = 'Tênis Feminino Cloud')
  returning id
)
insert into public.estoque (produto_id, tamanho, quantidade, ordem)
select p.id, t.tamanho, t.quantidade, t.ordem from p, (values ('33',1,0),('34',2,1),('35',3,2),('36',2,3),('37',2,4),('38',1,5),('39',0,6)) as t(tamanho, quantidade, ordem);

with p as (
  insert into public.produtos (nome, descricao, genero, categorias, tipo, cor_nome, cor1, cor2, preco, preco_de, novo, tags, ordem)
  select 'Regata Fitness Feminina', 'Costas nadador e tecido com toque gelado.', 'f', array['esportes']::text[], 'tank', 'Pink', '#C55D86', '#F2F0EA', 49.90, null, false, 'academia fitness', 12
  where not exists (select 1 from public.produtos where nome = 'Regata Fitness Feminina')
  returning id
)
insert into public.estoque (produto_id, tamanho, quantidade, ordem)
select p.id, t.tamanho, t.quantidade, t.ordem from p, (values ('P',2,0),('M',3,1),('G',2,2),('GG',1,3)) as t(tamanho, quantidade, ordem);

with p as (
  insert into public.produtos (nome, descricao, genero, categorias, tipo, cor_nome, cor1, cor2, preco, preco_de, novo, tags, ordem)
  select 'Chuteira Campo Pro', 'Travas altas para grama natural e cabedal sintético macio.', 'u', array['calcados','esportes']::text[], 'cleat', 'Azul royal', '#2A4FA8', '#F2F0EA', 259.90, null, false, 'futebol campo', 13
  where not exists (select 1 from public.produtos where nome = 'Chuteira Campo Pro')
  returning id
)
insert into public.estoque (produto_id, tamanho, quantidade, ordem)
select p.id, t.tamanho, t.quantidade, t.ordem from p, (values ('37',0,0),('38',1,1),('39',2,2),('40',2,3),('41',1,4),('42',1,5),('43',0,6),('44',0,7)) as t(tamanho, quantidade, ordem);

with p as (
  insert into public.produtos (nome, descricao, genero, categorias, tipo, cor_nome, cor1, cor2, preco, preco_de, novo, tags, ordem)
  select 'Mochila Esportiva 25L', 'Compartimento para notebook, bolso térmico e alças acolchoadas.', 'u', array['acessorios']::text[], 'backpack', 'Preto', '#2A2A2C', '#C29A5B', 149.90, 179.90, false, 'escola academia viagem', 14
  where not exists (select 1 from public.produtos where nome = 'Mochila Esportiva 25L')
  returning id
)
insert into public.estoque (produto_id, tamanho, quantidade, ordem)
select p.id, t.tamanho, t.quantidade, t.ordem from p, (values ('Único',4,0)) as t(tamanho, quantidade, ordem);

with p as (
  insert into public.produtos (nome, descricao, genero, categorias, tipo, cor_nome, cor1, cor2, preco, preco_de, novo, tags, ordem)
  select 'Boné Aba Curva', 'Ajuste traseiro e aba curva estruturada.', 'u', array['acessorios']::text[], 'cap', 'Preto', '#171717', '#C29A5B', 59.90, null, false, 'casual', 15
  where not exists (select 1 from public.produtos where nome = 'Boné Aba Curva')
  returning id
)
insert into public.estoque (produto_id, tamanho, quantidade, ordem)
select p.id, t.tamanho, t.quantidade, t.ordem from p, (values ('Único',8,0)) as t(tamanho, quantidade, ordem);

with p as (
  insert into public.produtos (nome, descricao, genero, categorias, tipo, cor_nome, cor1, cor2, preco, preco_de, novo, tags, ordem)
  select 'Calça Jogger Moletom', 'Moletom flanelado, punho na barra e cordão na cintura.', 'm', '{}'::text[], 'legging', 'Verde oliva', '#5B5E4E', '#E5E2DA', 119.90, 139.90, false, 'casual moletom', 16
  where not exists (select 1 from public.produtos where nome = 'Calça Jogger Moletom')
  returning id
)
insert into public.estoque (produto_id, tamanho, quantidade, ordem)
select p.id, t.tamanho, t.quantidade, t.ordem from p, (values ('P',2,0),('M',3,1),('G',3,2),('GG',1,3)) as t(tamanho, quantidade, ordem);

with p as (
  insert into public.produtos (nome, descricao, genero, categorias, tipo, cor_nome, cor1, cor2, preco, preco_de, novo, tags, ordem)
  select 'Sandália Salto Bloco', 'Salto bloco de 7 cm, firme e confortável para a noite toda.', 'f', array['calcados']::text[], 'heel', 'Vinho', '#8E1D2C', '#EDE9E1', 139.90, 169.90, false, 'festa salto', 17
  where not exists (select 1 from public.produtos where nome = 'Sandália Salto Bloco')
  returning id
)
insert into public.estoque (produto_id, tamanho, quantidade, ordem)
select p.id, t.tamanho, t.quantidade, t.ordem from p, (values ('33',0,0),('34',0,1),('35',0,2),('36',0,3),('37',0,4),('38',0,5),('39',0,6)) as t(tamanho, quantidade, ordem);

with p as (
  insert into public.produtos (nome, descricao, genero, categorias, tipo, cor_nome, cor1, cor2, preco, preco_de, novo, tags, ordem)
  select 'Camiseta Oversized TOP4', 'Modelagem ampla em algodão grosso. A cara da TOP4.', 'm', '{}'::text[], 'tshirt', 'Off-white', '#E6E3DB', '#141414', 89.90, null, true, 'casual moda', 18
  where not exists (select 1 from public.produtos where nome = 'Camiseta Oversized TOP4')
  returning id
)
insert into public.estoque (produto_id, tamanho, quantidade, ordem)
select p.id, t.tamanho, t.quantidade, t.ordem from p, (values ('P',4,0),('M',6,1),('G',5,2),('GG',3,3)) as t(tamanho, quantidade, ordem);

with p as (
  insert into public.produtos (nome, descricao, genero, categorias, tipo, cor_nome, cor1, cor2, preco, preco_de, novo, tags, ordem)
  select 'Short Feminino Fitness', 'Cós alto, tecido que não marca e não sobe no agachamento.', 'f', array['esportes']::text[], 'shorts', 'Lavanda', '#6E6194', '#F2F0EA', 54.90, null, false, 'academia fitness', 19
  where not exists (select 1 from public.produtos where nome = 'Short Feminino Fitness')
  returning id
)
insert into public.estoque (produto_id, tamanho, quantidade, ordem)
select p.id, t.tamanho, t.quantidade, t.ordem from p, (values ('P',2,0),('M',3,1),('G',2,2),('GG',1,3)) as t(tamanho, quantidade, ordem);

with p as (
  insert into public.produtos (nome, descricao, genero, categorias, tipo, cor_nome, cor1, cor2, preco, preco_de, novo, tags, ordem)
  select 'Bola Society Treino', 'Quique controlado para grama sintética.', 'u', array['esportes']::text[], 'ball', 'Branco / Azul', '#2A4FA8', '#2A4FA8', 79.90, null, false, 'futebol society', 20
  where not exists (select 1 from public.produtos where nome = 'Bola Society Treino')
  returning id
)
insert into public.estoque (produto_id, tamanho, quantidade, ordem)
select p.id, t.tamanho, t.quantidade, t.ordem from p, (values ('Único',2,0)) as t(tamanho, quantidade, ordem);

with p as (
  insert into public.produtos (nome, descricao, genero, categorias, tipo, cor_nome, cor1, cor2, preco, preco_de, novo, tags, ordem)
  select 'Squeeze Térmico 750ml', 'Mantém a água gelada por horas. Bico com trava.', 'u', array['acessorios','esportes']::text[], 'bottle', 'Dourado', '#C9A15C', '#151515', 34.90, null, false, 'academia treino', 21
  where not exists (select 1 from public.produtos where nome = 'Squeeze Térmico 750ml')
  returning id
)
insert into public.estoque (produto_id, tamanho, quantidade, ordem)
select p.id, t.tamanho, t.quantidade, t.ordem from p, (values ('Único',12,0)) as t(tamanho, quantidade, ordem);

with p as (
  insert into public.produtos (nome, descricao, genero, categorias, tipo, cor_nome, cor1, cor2, preco, preco_de, novo, tags, ordem)
  select 'Vestido Leve Estampado', 'Viscose fresquinha, perfeita para o calor do Maranhão.', 'f', '{}'::text[], 'dress', 'Terracota', '#C9874A', '#F6EBDA', 109.90, null, false, 'moda casual praia', 22
  where not exists (select 1 from public.produtos where nome = 'Vestido Leve Estampado')
  returning id
)
insert into public.estoque (produto_id, tamanho, quantidade, ordem)
select p.id, t.tamanho, t.quantidade, t.ordem from p, (values ('P',1,0),('M',2,1),('G',2,2),('GG',1,3)) as t(tamanho, quantidade, ordem);

with p as (
  insert into public.produtos (nome, descricao, genero, categorias, tipo, cor_nome, cor1, cor2, preco, preco_de, novo, tags, ordem)
  select 'Boné Trucker', 'Frente estruturada e tela traseira respirável.', 'u', array['acessorios']::text[], 'cap', 'Off-white', '#E3E0D8', '#141414', 54.90, 64.90, false, 'casual', 23
  where not exists (select 1 from public.produtos where nome = 'Boné Trucker')
  returning id
)
insert into public.estoque (produto_id, tamanho, quantidade, ordem)
select p.id, t.tamanho, t.quantidade, t.ordem from p, (values ('Único',0,0)) as t(tamanho, quantidade, ordem);

with p as (
  insert into public.produtos (nome, descricao, genero, categorias, tipo, cor_nome, cor1, cor2, preco, preco_de, novo, tags, ordem)
  select 'Regata Masculina Treino', 'Cavas amplas para liberdade total nos treinos.', 'm', array['esportes']::text[], 'tank', 'Chumbo', '#353538', '#C29A5B', 44.90, null, false, 'academia treino', 24
  where not exists (select 1 from public.produtos where nome = 'Regata Masculina Treino')
  returning id
)
insert into public.estoque (produto_id, tamanho, quantidade, ordem)
select p.id, t.tamanho, t.quantidade, t.ordem from p, (values ('P',3,0),('M',4,1),('G',3,2),('GG',2,3)) as t(tamanho, quantidade, ordem);
