# Lucid TikTok 🌙

**Lucid TikTok v1.0** — Mod do TikTok para iOS focado em **máxima eficiência energética (bateria)**, **design minimalista Liquid Glass Monochrome** e **alta performance no iPhone 17 (OLED & 120Hz ProMotion)**.

---

## ⚡ Principais Otimizações de Bateria & Performance

1. **Bloqueio Total de Anúncios e Rastreamento:**
   - Elimina anúncios em vídeo, cards patrocinados e rastreadores de marketing.
   - Reduz significativamente o tráfego em rede celular (5G/4G) e evita consumo desnecessário de CPU/GPU.
2. **Supressão Completa de Live Streams:**
   - Lives do TikTok mantêm conexões HLS/RTMP pesadas e WebSockets contínuos para renderizar comentários e presentes em tempo real. No Lucid TikTok, lives são suprimidas por padrão, impedindo aquecimento e drenagem de bateria ao rolar o feed na rua.
3. **Modo Pure (Clear Display com 1 Toque):**
   - Oculta botões, legendas e avatares com um simples toque no botão de UI limpa. Em telas OLED (como a do iPhone 17), píxeis pretos são desligados por completo, maximizando a autonomia.
4. **Downloads sem Marca D'água:**
   - Salve vídeos diretamente para a Galeria em alta definição sem marca d'água oficial e sem re-codificação pesada no aparelho.
5. **Limpeza Automática de Cache:**
   - Limpa fragmentos temporários e arquivos desnecessários na inicialização para preservar os 256GB do iPhone.
6. **Design Liquid Glass Monochrome:**
   - Paleta monocromática refinada com destaque Off-White (`#F5F5F7`), eliminando cores saturadas invasivas na interface de ajustes.

---

## 🛠️ Compilação e Instalação

Compilado via GitHub Actions utilizando Theos e injetado com `cyan` (`pyzule-rw`) com a flag `-u` (remoção de `UISupportedDevices` para compatibilidade total com o iPhone 17) e `-d` (habilitação de compartilhamento de arquivos).
