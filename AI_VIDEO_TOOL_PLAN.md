# AI 영상 / AI 영화 자동 제작 툴 — 레퍼런스 & 개발 계획서

> 작성일: 2026-11-22
> 목적: "아이디어(한 줄) → 대본 → 장면 → 이미지/영상 → 음성/음악 → 편집 → 업로드"를 자동화하는 툴 개발
> ⚠️ AI 영상 분야는 몇 달 단위로 판도가 바뀝니다. 아래 모델·가격·API는 **착수 전 공식 문서로 한 번 더 확인**하세요.

---

## 0. 한 줄 결론

**모델을 직접 만들지 말고, "오케스트레이션(파이프라인) + 일관성 유지 + 편집 자동화"를 만들어라.**
영상 생성 모델은 Google·OpenAI·Kuaishou·ByteDance 등 빅테크가 매달 갱신하는 원자재입니다.
돈이 쌓이는 곳(상류)은 **원자재를 갈아 끼워 쓰는 워크플로·템플릿·데이터·유통 채널**입니다.

---

## 1. 참고할 상용 서비스 (벤치마킹 대상)

### 1-1. 영상 생성 모델 / 플랫폼 (원자재)
| 서비스 | 특징 | API | 참고 포인트 |
|---|---|---|---|
| **Google Veo 3.x** (Flow, Gemini API / Vertex AI) | 텍스트→영상 + 네이티브 오디오(대사·효과음) | ✅ | 현재 품질 최상위권, 오디오 동시 생성 |
| **OpenAI Sora 2** (sora 앱 / API) | 물리·카메라 연출, 카메오(인물 삽입) | ✅ | 소셜형 UX 참고 |
| **Kling (Kuaishou)** | 가성비, 긴 클립, 이미지→영상 강함 | ✅ | 저비용 대량 생산용 |
| **Runway (Gen-4 계열)** | 캐릭터/씬 일관성(References), 편집 툴 | ✅ | 크리에이터 UX의 표준 |
| **Luma Dream Machine (Ray)** | 빠른 생성, 키프레임 제어 | ✅ | |
| **Pika** | 이펙트·짧은 숏폼 | 일부 | |
| **MiniMax Hailuo** | 저렴, 모션 품질 양호 | ✅ | |
| **ByteDance Seedance** | 멀티샷 일관성 | ✅(BytePlus 등) | |
| **Midjourney Video** | 이미지 미학 → 영상 | ❌(제한적) | 스타일 레퍼런스 |

### 1-2. "자동 제작" 완제품 (우리가 경쟁/차별화할 대상)
| 서비스 | 하는 일 | 배울 점 |
|---|---|---|
| **InVideo AI** | 프롬프트 → 대본·스톡/AI 영상·내레이션 자동 조립 | 엔드투엔드 UX |
| **Pictory / Lumen5** | 블로그·기사 → 영상 | 텍스트 재활용 파이프라인 |
| **Synthesia / HeyGen** | AI 아바타 + 립싱크 + 다국어 더빙 | 기업용 B2B 수익모델 |
| **CapCut (Dreamina)** | 템플릿·자동 자막·숏폼 | 템플릿 생태계 |
| **Opus Clip** | 롱폼 → 숏폼 자동 클립 | "재가공" 시장 |
| **LTX Studio** | 대본 → 스토리보드 → 샷 단위 영화 제작 | **AI 영화 툴의 가장 가까운 레퍼런스** |
| **Higgsfield** | 카메라 무빙 프리셋 | 프리셋 = 쉬운 UX |
| **Hedra** | 캐릭터 대사·립싱크 | 캐릭터 연기 |
| **Vrew (국내)** | 자동 자막·AI 목소리 편집 | 한국 시장 UX |

### 1-3. 오디오
| 서비스 | 용도 |
|---|---|
| **ElevenLabs** | TTS, 보이스 클론, 다국어 더빙, 효과음 (API ✅) |
| **Typecast / Supertone / CLOVA Voice (국내)** | 한국어 TTS 품질 우수 |
| **Suno / Udio** | AI 배경음악 생성 (상업 이용 약관 확인 필수) |
| **OpenAI / Google TTS** | 저가 대량 TTS |

---

## 2. 참고할 GitHub 오픈소스

### 2-1. 파이프라인/워크플로 엔진
| 레포 | 설명 |
|---|---|
| [comfyanonymous/ComfyUI](https://github.com/comfyanonymous/ComfyUI) | 노드 기반 이미지·영상 생성 워크플로. **API 모드로 백엔드 엔진**으로 쓰기 좋음 |
| [Comfy-Org/ComfyUI-Manager](https://github.com/Comfy-Org/ComfyUI-Manager) | 커스텀 노드 관리 |
| [Kosinkadink/ComfyUI-AnimateDiff-Evolved](https://github.com/Kosinkadink/ComfyUI-AnimateDiff-Evolved) | 애니메이션 생성 노드 |
| [kijai/ComfyUI-WanVideoWrapper](https://github.com/kijai/ComfyUI-WanVideoWrapper) | Wan 영상 모델 ComfyUI 래퍼 |

### 2-2. 오픈 영상 생성 모델 (자체 GPU 운용 시)
| 레포 | 설명 |
|---|---|
| [Wan-Video/Wan2.1 / Wan2.2](https://github.com/Wan-Video) | 알리바바 오픈 영상 모델, 현재 오픈소스 최상위권 |
| [Tencent/HunyuanVideo](https://github.com/Tencent/HunyuanVideo) | 텐센트 오픈 영상 모델 |
| [Lightricks/LTX-Video](https://github.com/Lightricks/LTX-Video) | 빠른 실시간급 생성 |
| [genmoai/mochi](https://github.com/genmoai/mochi) | Mochi 1 |
| [THUDM/CogVideo](https://github.com/THUDM/CogVideo) | CogVideoX |
| [hpcaitech/Open-Sora](https://github.com/hpcaitech/Open-Sora) | 오픈 Sora 재현 |

### 2-3. 자동 영상 제작 파이프라인 (가장 직접적인 참고)
| 레포 | 설명 |
|---|---|
| [harry0703/MoneyPrinterTurbo](https://github.com/harry0703/MoneyPrinterTurbo) | 키워드 → 대본(LLM) → 스톡영상 → TTS → 자막 → 합성. **MVP 구조 교과서** |
| [FujiwaraChoki/MoneyPrinter](https://github.com/FujiwaraChoki/MoneyPrinter) | 유튜브 쇼츠 자동화 원조 |
| [SamurAIGPT/Text-To-Video-AI](https://github.com/SamurAIGPT/Text-To-Video-AI) | 텍스트 → 영상 간단 파이프라인 |
| [RayVentura/ShortGPT](https://github.com/RayVentura/ShortGPT) | 숏폼 자동화 프레임워크 |
| [showlab/MovieAgent](https://github.com/showlab) / "Mora", "StoryAgent" 류 연구 | 멀티 에이전트 영화 제작 (감독·작가·촬영 에이전트) |

### 2-4. 편집·합성·후처리
| 레포 | 설명 |
|---|---|
| [FFmpeg/FFmpeg](https://github.com/FFmpeg/FFmpeg) | 모든 합성의 기반 |
| [Zulko/moviepy](https://github.com/Zulko/moviepy) | Python 영상 편집 |
| [remotion-dev/remotion](https://github.com/remotion-dev/remotion) | **React로 영상 렌더링** (자막·모션그래픽·템플릿에 최적, Node 친화) |
| [openai/whisper](https://github.com/openai/whisper) / [SYSTRAN/faster-whisper](https://github.com/SYSTRAN/faster-whisper) | 자동 자막 / 타임스탬프 |
| [m-bain/whisperX](https://github.com/m-bain/whisperX) | 단어 단위 정렬 자막 |
| [Rudrabha/Wav2Lip](https://github.com/Rudrabha/Wav2Lip), [OpenTalker/SadTalker](https://github.com/OpenTalker/SadTalker), LatentSync | 립싱크 |
| [xinntao/Real-ESRGAN](https://github.com/xinntao/Real-ESRGAN) | 업스케일 |
| [hzwer/ECCV2022-RIFE](https://github.com/hzwer/ECCV2022-RIFE) | 프레임 보간 (부드러운 영상) |
| [coqui-ai/TTS](https://github.com/coqui-ai/TTS), [fishaudio/fish-speech](https://github.com/fishaudio/fish-speech), CosyVoice | 오픈소스 TTS |

### 2-5. 캐릭터 일관성 (AI 영화의 핵심 난제)
| 레포/기법 | 설명 |
|---|---|
| IP-Adapter / InstantID / PuLID | 얼굴 고정 |
| LoRA 학습 (kohya-ss/sd-scripts, ai-toolkit) | 주인공 캐릭터 전용 모델 |
| FLUX.1 Kontext / Qwen-Image-Edit / Nano Banana(Gemini 이미지) | 레퍼런스 기반 이미지 편집으로 같은 인물 여러 장면 생성 |

---

## 3. 참고 사이트 / 커뮤니티 / API 집합소

| 분류 | 사이트 | 용도 |
|---|---|---|
| 모델 API 통합 | **fal.ai**, **Replicate**, **Runware**, **WaveSpeed** | 수십 개 영상 모델을 **하나의 API로** 호출 → 모델 교체 쉬움 (강력 추천) |
| LLM | OpenAI, Anthropic Claude, Google Gemini API | 대본·장면 분해·프롬프트 생성 |
| 모델 허브 | Hugging Face, Civitai | 오픈 모델·LoRA |
| GPU 클라우드 | RunPod, Modal, Vast.ai, Lambda | 오픈모델 자체 운용 |
| 비교/랭킹 | Artificial Analysis (Video Arena) | 모델 품질·가격 비교 |
| 트렌드 | r/StableDiffusion, r/aivideo, X(트위터) AI 크리에이터, ComfyUI 디스코드 | 최신 워크플로 |
| 스톡 소재 | Pexels API, Pixabay API | 무료 스톡 영상(초기 MVP) |
| 업로드 | YouTube Data API v3, TikTok Content Posting API, Instagram Graph API | 자동 배포 |

---

## 4. 무엇을 만들 것인가 — 포지셔닝 선택

| 옵션 | 타깃 | 난이도 | 수익화 속도 | 추천 |
|---|---|---|---|---|
| **A. 숏폼 자동 공장** (쇼츠/릴스/틱톡) | 1인 크리에이터, 마케터 | 하 | 빠름 | ⭐ **1단계** |
| **B. 광고·상품 영상 자동화** | 쇼핑몰·소상공인 (상품 URL → 광고영상) | 중 | 빠름, 객단가↑ | ⭐ **2단계 (B2B 현금흐름)** |
| **C. AI 단편영화/드라마 스튜디오** | 영상 작가, 웹툰·웹소설 IP 보유자 | 상 | 느림, 해자↑ | ⭐ **3단계 (장기 해자)** |
| D. 아바타/더빙 | 기업 교육, 다국어 | 중 | 중 | 레드오션(HeyGen 등) |

**권장 전략:** A로 파이프라인을 검증 → B로 현금흐름 확보 → C로 장기 해자(캐릭터·IP·템플릿 데이터) 구축.
한국 시장 특화(한국어 TTS 품질, 국내 쇼핑몰 연동—스마트스토어/쿠팡/카페24, 한국어 자막 스타일)는 글로벌 툴 대비 명확한 틈새.

---

## 5. 시스템 아키텍처

```
[사용자 입력] 한 줄 아이디어 / 대본 / 상품 URL / 웹소설 텍스트
      │
      ▼
① 기획 에이전트 (LLM)
   - 로그라인 → 시놉시스 → 대본 → 씬 → 샷 리스트(JSON)
   - 샷마다: 화면설명, 카메라, 길이, 대사, 등장인물, 분위기
      │
      ▼
② 비주얼 바이블 (일관성 레이어) ★핵심 해자
   - 캐릭터 시트(얼굴·의상 레퍼런스 이미지), 장소 시트, 스타일 가이드
   - 모든 샷 프롬프트에 자동 주입
      │
      ▼
③ 키프레임 생성 (이미지 모델) → 사용자 승인/재생성
      │
      ▼
④ 영상 생성 (Image→Video, 모델 라우터)
   - 샷 성격별로 최적 모델 자동 선택 (품질↔비용)
   - 큐 + 재시도 + 비용 상한
      │
      ▼
⑤ 오디오: TTS 대사 / 립싱크 / BGM / 효과음
      │
      ▼
⑥ 자동 편집: 컷 연결, 트랜지션, 자막(Whisper 정렬), 색보정, 업스케일
   (FFmpeg + Remotion)
      │
      ▼
⑦ 출력 & 배포: 16:9 / 9:16 리사이즈, 썸네일, 제목·해시태그, 예약 업로드
      │
      ▼
⑧ 성과 피드백: 조회수·시청지속률 수집 → 다음 기획 프롬프트 개선 (데이터 플라이휠)
```

### 핵심 설계 원칙
1. **모델 추상화 레이어**: `VideoProvider` 인터페이스 하나로 Veo/Kling/Runway/Wan 교체. 신모델 나오면 어댑터만 추가.
2. **샷 단위 JSON이 '진실의 원천'**: 모든 단계는 같은 프로젝트 JSON을 읽고 갱신 → 부분 재생성 가능.
3. **비동기 작업 큐**: 영상 생성은 수십 초~수 분. 웹훅/폴링 + 재시도 + 실패 샷만 재생성.
4. **비용 가드레일**: 프로젝트별 예상 비용 사전 표시, 상한 초과 시 중단. (영상 API는 초당 과금이라 원가 관리가 곧 마진)
5. **Human-in-the-loop**: 대본·키프레임 단계에서 승인 버튼 → 비싼 영상 생성 전 낭비 차단.

---

## 6. 기술 스택 (현재 레포가 Node 기반이므로 TypeScript 중심 제안)

| 레이어 | 추천 | 비고 |
|---|---|---|
| 프론트 | **Next.js + React + Tailwind**, 타임라인 UI | 스토리보드/샷 카드 편집기 |
| 백엔드 API | Next.js API Routes 또는 **NestJS / Fastify** | |
| 작업 큐 | **BullMQ + Redis** (또는 Inngest / Trigger.dev) | 장시간 생성 작업 |
| DB | **PostgreSQL (Supabase)** + Prisma | 프로젝트·샷·자산·과금 |
| 파일 저장 | **Cloudflare R2** / S3 | 영상 대용량, R2는 egress 무료 |
| LLM | Claude / GPT / Gemini (구조화 JSON 출력) | 대본·샷 분해 |
| 이미지·영상 모델 | **fal.ai / Replicate** (초기), 이후 자체 GPU(ComfyUI API) 일부 전환 | 원가 절감 |
| TTS | ElevenLabs + 국내 TTS(Typecast 등) | 한국어 품질 |
| 편집·렌더 | **FFmpeg + Remotion** (Remotion Lambda로 서버리스 렌더) | |
| 자막 | faster-whisper / whisperX (Python 마이크로서비스) | |
| 결제 | Stripe / 토스페이먼츠 / 포트원 | 국내 결제 |
| 인증 | Supabase Auth / Clerk | |
| 배포 | Vercel(프론트) + Railway/Fly.io(워커) + RunPod(GPU) | |

### 폴더 구조 예시
```
apps/
  web/            # Next.js 프론트 (스토리보드 편집기)
  worker/         # BullMQ 워커 (생성 작업 실행)
packages/
  core/           # 프로젝트/샷 JSON 스키마 (zod)
  providers/      # video/, image/, tts/, llm/ 어댑터
  planner/        # 대본→샷 분해 프롬프트·에이전트
  renderer/       # Remotion 컴포지션 + FFmpeg 유틸
  publisher/      # YouTube/TikTok 업로드
services/
  whisper/        # Python 자막 서비스
```

### 샷 스키마 예시 (zod)
```ts
const Shot = z.object({
  id: z.string(),
  sceneId: z.string(),
  durationSec: z.number().min(2).max(10),
  description: z.string(),          // 화면 묘사
  camera: z.enum(["wide","medium","closeup","dolly_in","pan","drone"]),
  characters: z.array(z.string()),  // 비주얼 바이블 캐릭터 ID
  dialogue: z.object({ characterId: z.string(), text: z.string() }).optional(),
  mood: z.string(),
  keyframeUrl: z.string().url().optional(),
  videoUrl: z.string().url().optional(),
  provider: z.string().optional(),  // "veo" | "kling" | "wan" ...
  status: z.enum(["draft","keyframe","generating","done","failed"]),
  costUsd: z.number().default(0),
});
```

---

## 7. 개발 로드맵

### Phase 1 — MVP: 숏폼 자동 공장 (2~4주)
- [ ] 주제 입력 → LLM 대본(30~60초) → 문장별 장면 분해
- [ ] 장면별 이미지 생성(또는 Pexels 스톡) → Image→Video 1개 모델 연동 (fal.ai)
- [ ] 한국어 TTS + Whisper 자막 + BGM
- [ ] FFmpeg/Remotion으로 9:16 합성 → MP4 다운로드
- [ ] **검증 지표:** 본인 채널 30개 업로드, 영상당 원가·제작시간·조회수 측정
- 참고: MoneyPrinterTurbo 구조를 그대로 TS로 재구성

### Phase 2 — 제품화 & 수익화 (1~2개월)
- [ ] 회원/크레딧 과금, 프로젝트 저장
- [ ] 스토리보드 편집기 (샷 카드 드래그, 개별 재생성)
- [ ] 멀티 모델 라우터 (저가/고급 모드)
- [ ] 템플릿 10종 (상품 리뷰, 뉴스 요약, 썰/괴담, 명언, 정보성 등)
- [ ] YouTube/TikTok 예약 업로드
- [ ] **상품 URL → 광고영상** (B2B 진입)

### Phase 3 — AI 영화 스튜디오 (3~6개월)
- [ ] 비주얼 바이블: 캐릭터 시트 + LoRA/레퍼런스로 인물 일관성
- [ ] 멀티샷 씬 구성, 카메라 프리셋, 대사 립싱크
- [ ] 장편 대본(웹소설/웹툰 원작) → 에피소드 단위 자동화
- [ ] 협업(팀 편집, 댓글), 버전 관리
- [ ] 오픈모델(Wan 등) 자체 GPU 운용으로 원가 50%↓

### Phase 4 — 머니댐 구조 (지속)
- [ ] 템플릿/캐릭터 **마켓플레이스** (크리에이터가 만들고 팔고, 수수료 수취)
- [ ] 성과 데이터 기반 "잘 터지는 대본" 자동 추천 (데이터 플라이휠)
- [ ] API 판매 (다른 서비스에 파이프라인 공급)
- [ ] 자체 운영 채널 포트폴리오 (툴로 직접 콘텐츠 생산 → 광고수익 + 툴 홍보)

---

## 8. 비즈니스 모델 — "머니댐" 설계

```
         [상류: 지속적 유입]
  템플릿 마켓 · 자체 채널 · SEO/쇼츠 바이럴 · B2B 영업
                  │
                  ▼
        ┌─────────────────────┐
        │  크레딧 구독 (SaaS)   │ ← 반복 매출 (MRR)
        │  B2B 광고영상 계약    │ ← 객단가↑
        │  API 사용료           │ ← 개발자 생태계
        │  마켓 수수료 20~30%   │ ← 남의 노동이 쌓이는 구조
        └─────────────────────┘
                  │
                  ▼
     [댐 수위 유지: 원가 관리 + 데이터 해자]
  모델 라우팅으로 원가↓ · 성과 데이터로 품질↑ · 전환비용(캐릭터·프로젝트 자산)
```

| 요금제(예시) | 가격 | 내용 |
|---|---|---|
| Free | 0원 | 워터마크, 월 3편 |
| Creator | 월 2~3만원 | 월 N크레딧, 워터마크 제거 |
| Pro | 월 7~10만원 | 고급 모델, 캐릭터 일관성, 예약업로드 |
| Business | 별도 견적 | 브랜드 키트, API, 대량 생산 |

**원가 규칙:** 판매 크레딧 가격 ≥ 모델 API 원가 × 3 (총이익률 60%+ 유지). 영상 모델 가격은 계속 떨어지므로 시간이 갈수록 마진은 커지는 구조.

**냉정한 리스크 평가**
| 리스크 | 대응 |
|---|---|
| 빅테크가 같은 기능을 무료로 출시 (CapCut, YouTube 자체 AI 등) | 범용이 아닌 **한국 시장·특정 업종(쇼핑몰·웹소설 IP)** 특화 |
| 모델 API 가격·정책 급변 | 멀티 프로바이더 + 오픈모델 백업 |
| 저작권/초상권 (실존 인물, 음악) | 실존인물 생성 차단 필터, 상업 라이선스 모델만 사용, 약관 명시 |
| 플랫폼 AI 콘텐츠 규제 (유튜브 '반복·양산형 콘텐츠' 수익화 제한, AI 라벨 의무) | AI 생성 표시 자동화, 템플릿 다양성·사람 편집 단계 유지 |
| 원가 폭주 | 사전 견적, 승인 후 생성, 사용자별 상한 |

---

## 9. 바로 시작하기 — 첫 주 할 일

1. **fal.ai / Replicate 계정** 생성 → Kling·Veo·Wan 영상 1개씩 생성해 품질·가격 비교표 작성
2. **MoneyPrinterTurbo 로컬 실행** → 파이프라인 흐름 체득
3. **ComfyUI 설치** → Wan2.x Image→Video 워크플로 실행해 보기 (GPU 없으면 RunPod)
4. **Remotion 예제** 실행 → 자막+이미지+오디오 합성 템플릿 1개 제작
5. 이 레포에 `packages/core` 샷 스키마 + `providers/video/fal.ts` 어댑터부터 구현
6. 본인 숏폼 채널 개설 → 툴로 만든 영상 매일 1개 업로드 (제품 검증 + 상류 유입 채널 동시 확보)

---

## 10. 체크리스트: 착수 전 확인할 것
- [ ] 각 모델 API의 **상업적 이용 약관**과 생성물 소유권
- [ ] 음악 생성(Suno/Udio) 상업 라이선스 조건
- [ ] YouTube/TikTok의 AI 콘텐츠 표시·수익화 정책 최신본
- [ ] 개인정보(얼굴 업로드) 처리방침 — 국내 개인정보보호법
- [ ] 모델별 초당 단가 최신 가격 → 요금제 원가 계산
