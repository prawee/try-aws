FROM public.ecr.aws/lambda/nodejs:22 AS builder
WORKDIR /usr/app
COPY package.json index.ts  ./
RUN npm install
RUN npm run build
    
FROM public.ecr.aws/lambda/nodejs:22
WORKDIR ${LAMBDA_TASK_ROOT}
COPY --from=builder /usr/app/dist/* ./
CMD ["index.handler"]