% �ٶ���һ��HMM��ѵ�����HMM��
% ����һ��۲�ֵ�������HMM���������۲�ֵ��HMM��ƥ��ȡ�
% �޸ģ�������
% �޸Ĳ���Ϊ����� HMM2 ģ�͡�����һ���۲����и��ӷ����ĸ��ĸ�HMMģ�͡�
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% O���۲�״̬��
O = 7;
O2 = 7;
% Q��HMM״̬��
Q = 5;
Q2 = 5;
%ѵ�������ݼ�,ÿһ�����ݾ���һ��ѵ���Ĺ۲�ֵ
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
% ��ʼ������
prior1 = normalise(rand(Q,1));
transmat1 = mk_stochastic(rand(Q,Q));
obsmat1 = mk_stochastic(rand(Q,O));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ��Ӳ���
    prior3 = normalise(rand(Q2,1));
    transmat3 = mk_stochastic(rand(Q2,Q2));
    obsmat3 = mk_stochastic(rand(Q2,O2));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% improve guess of parameters using EM
% ��data���ݼ�ѵ�����������γ��µ�HMMģ��
[LL, prior2, transmat2, obsmat2] = dhmm_em(data, prior1, transmat1, obsmat1, 'max_iter', size(data,1));
% ѵ�������й۲�ֵ��HMMƥ���
LL
% ѵ����ĳ�ʼ���ʷֲ�
prior2
% ѵ�����״̬ת�Ƹ��ʾ���
transmat2
% �۲�ֵ���ʾ���
obsmat2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ��Ӳ���
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
% loglik ������data�����hmm(������Ϊprior2, transmat2, obsmat2)��ƥ��ֵ��Խ��˵��Խƥ�䣬0Ϊ����ֵ��
% pathΪviterbi�㷨�Ľ������������path
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ��Ӳ���
loglik2 = dhmm_logprob(data1, prior4, transmat4, obsmat4)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

B = multinomial_prob(data1,obsmat2);
path = viterbi_path(prior2, transmat2, B)
save('sa.mat');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ��Ӳ���
    B2 = multinomial_prob(data1,obsmat4);
    path2 = viterbi_path(prior4, transmat4, B2)
    save('sa2.mat');
    if loglik2 > loglik 
        fuhe = 2
    else
        fuhe = 1
    end    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
