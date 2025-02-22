# 使用Node.js官方镜像作为基础镜像，选择合适的版本
FROM node:18-slim

# 设置工作目录
WORKDIR /app

# 复制package.json和package-lock.json到工作目录
COPY package*.json ./

# 安装项目依赖
RUN npm ci

# 复制项目所有文件到工作目录
COPY . .

# 构建静态网站内容
RUN npm run build

# 暴露端口，Docusaurus默认开发服务器端口是3000
EXPOSE 3000

# 启动本地开发服务器（如果需要运行开发环境）
# CMD ["npm", "start"]

# 如果是为了部署，可使用静态文件服务器来提供内容，这里以serve为例
# 先全局安装serve
RUN npm install -g serve
# 启动serve来提供静态文件
CMD ["serve", "-s", "build", "-l", "3000"]