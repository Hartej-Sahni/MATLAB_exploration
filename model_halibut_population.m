K = 300000;
r = 0.25;
u_0 = 189284;
t = 0:136;
[rows, cols] = size(t);

u = zeros(1, cols);
u(1) = u_0;
for i = 2:cols
    u(i) = K / (1 + (exp(-1*r*t(i)) * (K/u_0 - 1)));
end

figure(1)
plot(t, u)
xlabel("Years")
ylabel("Metric Tons")
title("Pacific Halibut Biomass")

h = 0.12;
d = 0.08;
m = h + d;
u = zeros(1, cols);
u(1) = u_0;
for i = 2:cols
    u(i) = ((1 - m/r) * K) / (1 + (exp(-1*(r-m)*t(i)) * (K*(1 - m/r)/u_0 - 1)));
end

figure(2)
plot(t, u)
xlabel("Years")
ylabel("Metric Tons")
title("Pacific Halibut Biomass with m = 0.2")

u_harvest = zeros(1, cols);
u_harvest(1) = u_0;
h_actual = [0.00	0.00	0.00	0.01	0.01	0.01	0.01	0.01	0.01	0.02	0.02	0.02	0.03	0.04	0.05	0.05	0.05	0.04	0.07	0.09	0.09	0.10	0.11	0.13	0.15	0.18	0.21	0.25	0.21	0.23	0.20	0.23	0.28	0.34	0.30	0.38	0.43	0.44	0.49	0.56	0.61	0.71	0.70	0.65	0.63	0.62	0.55	0.53	0.51	0.47	0.45	0.44	0.45	0.44	0.42	0.43	0.42	0.40	0.43	0.39	0.38	0.36	0.37	0.35	0.38	0.35	0.40	0.32	0.36	0.33	0.35	0.38	0.41	0.41	0.45	0.45	0.39	0.42	0.43	0.41	0.37	0.44	0.44	0.39	0.37	0.28	0.19	0.23	0.23	0.17	0.16	0.15	0.13	0.13	0.13	0.15	0.16	0.18	0.21	0.20	0.20	0.17	0.15	0.13	0.13	0.13	0.12	0.08	0.08	0.10	0.11	0.12	0.12	0.13	0.15	0.17	0.19	0.21	0.23	0.23	0.23	0.23	0.23	0.19	0.16	0.14	0.11	0.11	0.11	0.12	0.11	0.12	0.12	0.14	0.15	0.14	0.13];
for i = 2:cols
    u_harvest(i) = ((1 - h_actual(i)/r) * K) / (1 + (exp(-1*(r-h_actual(i))*t(i)) * (K*(1 - h_actual(i)/r)/u_0 - 1)));
end

u_mortality = zeros(1, cols);
u_mortality(1) = u_0;
mortality_rates = [0.00	 0.00	0.00	0.01	0.01	0.01	0.01	0.01	0.01	0.02	0.02	0.02	0.03	0.04	0.05	0.05	0.05	0.04	0.07	0.09	0.09	0.10	0.11	0.13	0.15	0.18	0.21	0.25	0.21	0.23	0.20	0.23	0.28	0.34	0.30	0.38	0.43	0.44	0.49	0.56	0.61	0.71	0.70	0.65	0.63	0.62	0.55	0.53	0.51	0.47	0.45	0.44	0.45	0.44	0.42	0.43	0.42	0.40	0.43	0.39	0.38	0.36	0.37	0.35	0.38	0.35	0.40	0.32	0.36	0.33	0.35	0.38	0.41	0.41	0.50	0.51	0.49	0.56	0.55	0.53	0.48	0.56	0.57	0.56	0.54	0.43	0.36	0.34	0.34	0.27	0.25	0.25	0.24	0.22	0.19	0.20	0.21	0.23	0.26	0.26	0.26	0.23	0.21	0.20	0.20	0.19	0.18	0.13	0.13	0.14	0.15	0.16	0.16	0.17	0.20	0.23	0.26	0.30	0.31	0.33	0.34	0.34	0.34	0.29	0.25	0.23	0.20	0.19	0.19	0.19	0.18	0.20	0.19	0.22	0.24	0.22	0.21];
for i = 2:cols
    % Avoid division by 0 if mortality rate is same as growth rate
    if (mortality_rates(i) == r)
        mortality_rates(i) = mortality_rates(i) + 0.0001;
    end
    u_mortality(i) = ((1 - mortality_rates(i)/r) * K) / (1 + (exp(-1*(r-mortality_rates(i))*t(i)) * (K*(1 - mortality_rates(i)/r)/u_0 - 1)));
end

figure(3)
plot(t, u_harvest)
hold on
plot(t, u_mortality)
xlabel("Years")
ylabel("Metric Tons")
title("Calculated Biomass with Actual Harvest Rates and Mortality Rates")
legend("Harvest", "Mortality")

u_actual = [u_0	189193	189148	189148	189012	188694	188286	187832	189012	190826	194183	199943	207881	216590	225163	233237	240494	245439	250564	250201	243987	233237	219901	204842	186290	166151	144877	124829	106367	94710	85366	80331	75750	70397	64365	61280	56699	52208	48534	44588	40234	36151	32205	30844	32024	34337	37058	40324	43908	47491	50349	52390	53478	53751	54567	56200	57742	60328	62868	64592	66542	68901	70942	72257	75160	76566	80331	81828	84912	84640	84051	84096	79560	77474	75251	71713	70261	68492	65453	61689	59783	59738	56518	53751	52072	51755	51029	53478	55157	58105	63276	69354	77337	88269	100743	114351	124057	137892	148960	156897	171412	179759	188377	200896	208108	205795	206384	241356	256234	284584	287577	282724	267030	244441	219040	193139	171186	151953	135851	123785	113806	102194	96660	93576	93077	95980	97885	99972	102512	101060	95209	89947	83461	77337	73573	70443	70261];
figure(4)
plot(t, u_actual)
xlabel("Years")
ylabel("Metric Tons")
title("Pacific Halibut Female Spawning Biomass")
hold on
plot(t, u_mortality)
legend("Actual Biomass", "Calculated Biomass with Mortality Rate")

t = 0:20;
[rows, cols] = size(t);
K = 100000;

u_constant_low_h_predict = zeros(1, cols);
u_constant_low_h_predict(1) = u_actual(137);
h = 0.12;
m = h + d;
for i = 2:cols
    u_constant_low_h_predict(i) = ((1 - m/r) * K) / (1 + (exp(-1*(r-m)*t(i)) * (K*(1 - m/r)/u_constant_low_h_predict(1) - 1)));
end

figure(5)
plot(t, u_constant_low_h_predict)
xlabel("Years")
ylabel("Metric Tons")
title("Pacific Halibut Biomass Prediction")

u_constant_high_h_predict = zeros(1, cols);
u_constant_high_h_predict(1) = u_actual(137);
h = 0.62;
m = h + d;
for i = 2:cols
    u_constant_high_h_predict(i) = ((1 - m/r) * K) / (1 + (exp(-1*(r-m)*t(i)) * (K*(1 - m/r)/u_constant_high_h_predict(1) - 1)));
end

hold on
plot(t, u_constant_high_h_predict)

u_predict = zeros(1, cols);
u_predict(1) = u_actual(137);
h_low = 0.07;
h_high = 0.17;
for i = 2:cols
    m = d + (h_low + (h_high - h_low) * rand(1));
    u_predict(i) = ((1 - m/r) * K) / (1 + (exp(-1*(r-m)*t(i)) * (K*(1 - m/r)/u_predict(1) - 1)));
end

hold on
plot(t, u_predict)
legend("Constant h = 0.12", "Constant h = 0.62", "Random h")

biomass_threshold = 0.25*K;
u_not_below_threshold_predict = zeros(1, cols);
u_not_below_threshold_predict(1) = u_actual(137);
h = 0.62;
m = h + d;
for i = 2:cols
    u_not_below_threshold_predict(i) = ((1 - m/r) * K) / (1 + (exp(-1*(r-m)*t(i)) * (K*(1 - m/r)/u_not_below_threshold_predict(1) - 1)));
    while (u_not_below_threshold_predict(i) < biomass_threshold)
        h = h/2;
        m = h + d;
        u_not_below_threshold_predict(i) = ((1 - m/r) * K) / (1 + (exp(-1*(r-m)*t(i)) * (K*(1 - m/r)/u_not_below_threshold_predict(1) - 1)));    
    end
end

figure(6)
plot(t, u_constant_low_h_predict)
xlabel("Years")
ylabel("Metric Tons")
title("Pacific Halibut Biomass Prediction with Threshold")
hold on
plot(t, u_not_below_threshold_predict)
plot(t, u_predict)
legend("Constant h = 0.12", "Starting h = 0.62", "Random h")