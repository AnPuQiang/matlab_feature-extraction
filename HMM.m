% ①定义一个HMM并训练这个HMM。
% ②用一组观察值测试这个HMM，计算该组观察值域HMM的匹配度。
% 修改：旺齐齐
% 修改部分为：添加 HMM2 模型。测试一个观察序列更加符合哪个哪个HMM模型。
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% O：观察状态数
O = 7;
O2 = 7;
% Q：HMM状态数
Q = 5;
Q2 = 5;
%训练的数据集,每一行数据就是一组训练的观察值
data=[1,2,3,1,2,2,4,2,3,1,2,7,2;
      1,2,3,6,2,2,1,4,3,1,5,3,1;
      1,2,3,1,2,5,1,2,4,1,2,3,2;
      1,2,7,1,2,2,1,2,5,1,2,4,1;
      5,2,3,3,5,2,1,2,3,1,2,3,6;
      1,2,3,1,2,2,1,6,5,1,2,6,4;
      5,2,3,4,4,2,1,2,3,1,2,5,6;
      1,2,6,1,2,2,1,2,3,1,4,3,2;
      1,2,3,4,2,7,1,4,3,1,7,3,3;
      5,2,3,5,2,2,1,2,3,1,2,3,4;
      5,2,4,1,2,2,5,2,3,7,1,6,2;]

  data2 = [1,2,3,1,2,2,4,2,3,1,2,7,2;
          1,2,3,6,2,2,1,4,3,1,5,3,1;
          1,2,3,1,2,5,1,2,4,1,2,3,2;
          1,2,7,1,2,2,1,2,5,1,2,4,1;
          5,2,3,3,5,2,1,2,3,1,2,3,6;
          1,2,3,1,2,2,1,6,5,1,2,6,4;
          5,2,3,4,4,2,1,2,3,1,2,5,6;
          1,2,6,1,2,2,1,2,3,1,4,3,2;
          1,2,3,4,2,7,1,4,3,1,7,3,3;
          5,2,3,5,2,2,1,2,3,1,2,3,4;
          4,2,5,1,2,2,6,2,3,7,1,6,4;]
% initial guess of parameters
% 初始化参数
prior1 = normalise(rand(Q,1));
transmat1 = mk_stochastic(rand(Q,Q));
obsmat1 = mk_stochastic(rand(Q,O));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 添加部分
    prior3 = normalise(rand(Q2,1));
    transmat3 = mk_stochastic(rand(Q2,Q2));
    obsmat3 = mk_stochastic(rand(Q2,O2));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% improve guess of parameters using EM
% 用data数据集训练参数矩阵形成新的HMM模型
[LL, prior2, transmat2, obsmat2] = dhmm_em(data, prior1, transmat1, obsmat1, 'max_iter', size(data,1));
% 训练后那行观察值与HMM匹配度
LL
% 训练后的初始概率分布
prior2
% 训练后的状态转移概率矩阵
transmat2
% 观察值概率矩阵
obsmat2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 添加部分
    [LL2, prior4, transmat4, obsmat4] = dhmm_em(data2, prior3, transmat3, obsmat3, 'max_iter', size(data2,1));
    LL2
    prior4
    transmat4
    obsmat4
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% use model to compute log likelihood
% data1=[1,2,3,1,2,2,1,2,3,1,2,3,1]
data1 = [5,2,4,1,2,2,5,2,3,7,1,6,2]
loglik = dhmm_logprob(data1, prior2, transmat2, obsmat2)
% log lik is slightly different than LL(end), since it is computed after the final M step
% loglik 代表着data和这个hmm(三参数为prior2, transmat2, obsmat2)的匹配值，越大说明越匹配，0为极大值。
% path为viterbi算法的结果，即最大概率path
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 添加部分
loglik2 = dhmm_logprob(data1, prior4, transmat4, obsmat4)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

B = multinomial_prob(data1,obsmat2);
path = viterbi_path(prior2, transmat2, B)
save('sa.mat');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 添加部分
    B2 = multinomial_prob(data1,obsmat4);
    path2 = viterbi_path(prior4, transmat4, B2)
    save('sa2.mat');
    if loglik2 > loglik 
        fuhe = 2
    else
        fuhe = 1
    end    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
