# AI Drama Factory 🎬

AI 驱动的短剧自动生成系统 - 从小说到视频的一站式解决方案。

## ✨ 核心特性

- **配置优先** - 所有参数提前设置，生成过程无需交互问答
- **一键生成** - 支持批量处理，后台静默执行完整流程
- **可插拔架构** - AI 模型、厂商 API、提示词模板均可动态配置
- **流程可控** - 可选择启用/跳过任意步骤（如跳过导演审核）

## 🛠️ 技术栈

| 层级 | 技术 |
|------|------|
| 后端 | Python + FastAPI |
| 前端 | Vue 3 + Vite |
| 桌面 | Tauri |
| 数据库 | SQLite + SQLAlchemy |

## 🤖 支持的 AI 服务

### LLM 提供商
| 全球 | 国内 |
|------|------|
| OpenAI (GPT-4o) | DeepSeek |
| Anthropic (Claude) | 豆包 (字节跳动) |
| Google (Gemini) | 通义千问 (阿里) |
| | 智谱 AI (GLM-4) |
| | Moonshot (月之暗面) |

### 图像/视频提供商
- 火山引擎
- RunningHub
- OpenAI DALL-E / Sora

## 🚀 快速开始

### 后端

```bash
cd backend

# 创建虚拟环境
python -m venv venv
venv\Scripts\activate  # Windows
# source venv/bin/activate  # Linux/Mac

# 安装依赖
pip install -r requirements.txt

# 配置环境变量
copy .env.example .env
# 编辑 .env 填入 API 密钥

# 启动服务
uvicorn app.main:app --reload --port 8000
```

访问 http://localhost:8000/docs 查看 API 文档。

### 前端（待开发）

```bash
cd frontend
npm install
npm run dev
```

## 📁 项目结构

```
ai-drama-factory/
├── backend/
│   ├── app/
│   │   ├── main.py           # FastAPI 入口
│   │   ├── config.py         # 配置管理
│   │   ├── database.py       # 数据库连接
│   │   ├── models/           # 数据模型
│   │   ├── routers/          # API 路由
│   │   ├── services/         # 业务逻辑
│   │   └── providers/        # AI 适配器
│   │       ├── llm/          # LLM 提供商
│   │       ├── image/        # 图像生成
│   │       └── video/        # 视频生成
│   ├── templates/            # 提示词模板
│   └── requirements.txt
└── frontend/                 # Vue 3 前端（待开发）
```

## 📖 API 端点

| 端点 | 方法 | 描述 |
|------|------|------|
| `/api/projects` | GET/POST | 项目列表/创建 |
| `/api/projects/{id}` | GET/PUT/DELETE | 项目详情/更新/删除 |
| `/api/projects/{id}/config` | PUT | 更新项目配置 |
| `/api/novels` | POST | 添加小说/章节 |
| `/api/novels/upload/{project_id}` | POST | 上传小说文件 |
| `/api/generate/{project_id}/storyline` | POST | 生成故事线 |
| `/api/generate/{project_id}/outline` | POST | 生成大纲 |
| `/api/generate/{project_id}/one-click` | POST | 一键生成 |
| `/api/providers` | GET | 获取可用 AI 提供商 |

## 🔧 配置说明

项目配置存储在 `project_configs` 表中，主要包括：

```yaml
# 基础设置
target_episodes: 10        # 目标集数
episode_duration: 60       # 单集时长(秒)

# 流程控制
enable_storyline: true     # 生成故事线
enable_outline: true       # 生成大纲
enable_director_review: false  # 跳过导演审核 ⭐
enable_assets: true        # 生成资产
enable_script: true        # 生成剧本
enable_storyboard: true    # 生成分镜
enable_image: true         # 生成图片
enable_video: false        # 生成视频

# LLM 配置
llm_provider: "deepseek"
llm_model: "deepseek-chat"

# 分镜设置
grid_size: 4               # 宫格数量
shots_per_segment: 4       # 每片段镜头数
```

## 📝 License

MIT License
