# Automatic Detection of Ventricular Fibrillation through Electrocardiogram

Please be aware that numerous variations and experiments were conducted during this study. However, only the automatic method that yielded the most favorable outcome has been included in this summary of the work. To access the entire study, please read the full [report](Projeto_Rúben_93203.pdf) (portuguese).

## Motivation

According to the National Health Service (SNS), heart diseases continue to be the leading cause of death in Portugal, accounting for more than 35 thousand annual deaths in our country. These numbers reflect about one-third of the total annual national mortalities, highlighting an extreme concern in this area. 
Nevertheless, the inevitability of these cardiac problems occurring compels society to seek new solutions to prevent further fatal cases. Ventricular fibrillation is an emergency condition where the heart rate is uncontrolled and extremely high. Therefore, this work is based on the construction of an algorithm capable of detecting ventricular fibrillation by exploiting ECG characteristics. 

## Goals
- **Main Goal**: Construction of an algorithm capable of detecting ventricular fibrillation by exploiting ECG characteristics.
- Study the literature and extract some promising metrics for ventricular fibrillation.
- Reviewing and analyse these metrics independently.
- Multivariate analysis in order to enhance the discriminatory power of these metrics.
- Study the influence of metrics by using an unsupervised learning to verify if the data was grouped according to the two different conditions.
- Implement a supervised learning to automatically identify ventricular fibrillation events.  


## Methods

In this chapter, we will discuss how the entire algorithm was developed, including the following processes: signal filtering, selection and extraction of metrics, selection of time windows for metric calculation, evaluation of metrics, and classification methodology. Figure 1 schematically represents the different phases of the defined algorithm.

![workflow](https://github.com/rubensilvab/Automatic-Detection-of-Ventricular-Fibrillation-through-Electrocardiogram/assets/130314085/68c425f8-1d85-4973-9b53-257e6c6716b5)

 **Figure 1.**          *Workflow of the algorithm proposed (Preprocess -> feature extraction -> Statistical Analysis(boxplot/Hypothesis test) -> Classification)*



### Dataset 

The chosen database for this project is the CU Ventricular Tachyarrhythmia Database available on the Physionet website [^1]. It comprises 35 ECGs from patients experiencing periods of ventricular tachycardia and ventricular fibrillation. Each ECG was sampled at 250 Hz for approximately 8.5 minutes, corresponding to 127,232 samples. The signals have been pre-processed with a second-order low-pass filter with a cutoff frequency of 70 Hz. Importantly, each subject's ECG includes annotations indicating the electrocardiogram's state, including episodes of ventricular fibrillation.

To ensure a balance between participant quantity and the number of samples with the pathology, a selection process was conducted. Twenty-five subjects were chosen, each with at least 10,000 samples (40 seconds) for each episode of fibrillation and without fibrillation (control group). This approach maintains a considerable number of participants while preserving essential ECG signal information.

### Preprocessing

Preprocessing involves attenuating all irrelevant information from the signal that contaminates and prevents an accurate assessment of it. This irrelevant information is commonly referred to as noise.

#### Electrical network interference

The ECG of an individual is obtained by placing electrodes in specific areas of the human body. These electrodes detect ionic flow within the body by measuring the potential difference between them, making the correct direction and placement crucial for good visualization and ECG acquisition. In most cases, one electrode serves as a reference (ground) and is connected to an amplifier, which amplifies the signal in common mode corresponding to electrical network interference, typically at a fundamental frequency of about 50/60 Hz. To address this, it's necessary to construct a filter to remove these 60 Hz harmonics and artifacts.

Through various studies, it has been proven that the zero-phase in radians per sample corresponds to the frequency that the filter rejects, where the gain is lower. Conversely, the pole-phase defines the frequencies with higher gain. Therefore, to remove interference from the electrical grid, which has a frequency of 60 Hz, it suffices to set the phase in normalized angular frequency (radians per sample) of the zero corresponding to the 60 Hz frequency (Figure 2).

- The calculation performed corresponds to the conversion into normalized angular frequency, which is (60/Fa) * 2π, as w = 2πf. The division by the sampling frequency is due to the signal digitization.

  <img width="1171" alt="filtro60" src="https://github.com/rubensilvab/Automatic-Detection-of-Ventricular-Fibrillation-through-Electrocardiogram/assets/130314085/c3f36bc4-d38d-47a7-adf0-381a6835a09c">

**Figure 2.**          *Map of poles and zeros of the filter and Frequency reponse*
  

![rede_eletrica](https://github.com/rubensilvab/Automatic-Detection-of-Ventricular-Fibrillation-through-Electrocardiogram/assets/130314085/dd60cc80-d7d4-4740-a777-25609fe61b93)

**Figure 3.**          *Application of the filter*

Although the difference is not as evident, we can observe a reduction in the small oscillations in the lower graph compared to the upper one, where the signal is not filtered (Figure 3).

#### Baseline Correction

The original ECG often shows low-frequency oscillations in its baseline, possibly due to patient movement or breathing. These oscillations, with frequencies around 0.15 to 0.3 Hz, need removal before analyzing the biosignal. A moving average filter can effectively eliminate this noise. First, average the 200 ms PR interval samples. Then, repeat for subsequent 200 ms samples until the signal's end. Use these averages as input for a similar procedure with 600 ms intervals, continuously until the signal's end.

![correçao_linhadebase](https://github.com/rubensilvab/Automatic-Detection-of-Ventricular-Fibrillation-through-Electrocardiogram/assets/130314085/b6f0e31d-3f31-4340-bef5-2e4874dabb26)

**Figure 5.**          *Effect of the moving average filter*

### Feature Extraction

#### Introduction to spectral domain analysis

Our database is defined in the time domain since the signal was acquired and recorded over time with a sampling frequency of 250 samples per second. However, we know that it is possible to convert and analyze the signal in the spectral domain using the discrete Fourier transform.

<img width="889" alt="fourier" src="https://github.com/rubensilvab/Automatic-Detection-of-Ventricular-Fibrillation-through-Electrocardiogram/assets/130314085/7b15fe71-c5cb-4c0e-aa1f-98cf4068adf4">

**Equation 1.**          *Where X(k) represents the N coefficients in the frequency domain and 2𝛱/N, the frequency resolution in radians/sample.*

<img width="1175" alt="fourierex" src="https://github.com/rubensilvab/Automatic-Detection-of-Ventricular-Fibrillation-through-Electrocardiogram/assets/130314085/c6c17059-2fab-4476-b04d-33a523e4092a">

**Figure 6.**          *Presentation of the signals in the time domain on the left side and in the spectral domain on the right side for the control ECG without pathology and the ECG with pathology. Note: VF-Ventricular Fibrillation.*

The analysis of Power Spectral Density (PSD) is a very useful and common procedure in various biomedical signals. One way to estimate this measure is by calculating the square of the absolute value of the Fast Fourier Transform (FFT). There are several methods to calculate and obtain the PSD, all of which are based on the periodogram.

A Welch Power Spectral Density is calculated by averaging periodograms. Firstly, the signal is divided into K segments, each with M samples. However, most of the time these segments have a certain percentage of overlap. Then, each segment is multiplied by a window function w(n) (such as Hamming, Hann, Kaiser, Rectangular, etc.). Only after these steps are applied to a segment, it undergoes Fourier transformation and the respective periodogram calculation.

<img width="856" alt="perio" src="https://github.com/rubensilvab/Automatic-Detection-of-Ventricular-Fibrillation-through-Electrocardiogram/assets/130314085/dc145d94-9ece-4c8b-8ac7-e63efb2aee2d">

**Equation 2.** *The average of the periodograms over the total number of segments K.*

<img width="1115" alt="period" src="https://github.com/rubensilvab/Automatic-Detection-of-Ventricular-Fibrillation-through-Electrocardiogram/assets/130314085/cd0c13f4-e5b8-4b55-9b6b-fb33dc18d48a">

**Figure 7.**          *Power spectral density for patient 1 (cu01). Note: VF-Ventricular Fibrillation.*

The observation and analysis of Figure 7 confirm the initial impressions regarding the Fourier transform magnitude, showing that for this patient, the predominant frequencies in the ECG without anomalies are lower than those in the presence of the disease.

#### Fundamental Frequency

The fundamental frequency is the predominant frequency in a certain signal, meaning it is the strongest and contributes the most to the power density among all the harmonics that make up, in our case, the ECG.

<img width="1136" alt="FundFrq" src="https://github.com/rubensilvab/Automatic-Detection-of-Ventricular-Fibrillation-through-Electrocardiogram/assets/130314085/7d3f1d3b-2baf-44df-990c-0adf2241fc15">

**Figure 7.**          *Visualization of the fundamental frequency through the power spectral density for patient 1.*

#### Average Frequency

All frequencies in the signal contribute to its power density, with some contributing more than others. By analyzing these contributions and performing calculations, we find the average ECG frequency. With pwelch, generating Sw and Fw, we normalize Sw to unity, as it represents frequency contributions in power density.

<img width="966" alt="normsw" src="https://github.com/rubensilvab/Automatic-Detection-of-Ventricular-Fibrillation-through-Electrocardiogram/assets/130314085/3972ef65-908a-46f0-b712-fd83c0602f1f">

**Equation 3.**          *Normalization of the SW.*

Now, simply multiply each frequency by its respective contribution to power density, then sum all these values together.

#### Power

Since the power spectral density shows us the power that each frequency contributes to the signal, summing the contribution of all frequencies will give us the total power of the analyzed segment. Thus, the total power is nothing more than the area under the entire power spectral density plot.

<img width="1116" alt="power" src="https://github.com/rubensilvab/Automatic-Detection-of-Ventricular-Fibrillation-through-Electrocardiogram/assets/130314085/d8c55931-528e-4f59-8a77-1dcd824e1cf0">

**Figure 8.**          *Visualization of the power through the power spectral density for patient 1.*

#### N(%) - Percentage of samples exceeding a value V0

The two new metrics presented are obtained through an analysis of the ECG in the time domain. In the TCSC algorithm, each 3-second segment of the ECG is analyzed and investigated. Each segment is multiplied by a window defined as:

<img width="1122" alt="w(t)" src="https://github.com/rubensilvab/Automatic-Detection-of-Ventricular-Fibrillation-through-Electrocardiogram/assets/130314085/89e15064-6f88-4459-b39c-c1519587137c">

**Equation 4.**          *Window W(t), Ls=3s*

Figure 9 shows the result of multiplying this window by our 3-second segment.

<img width="1121" alt="wxw(t)" src="https://github.com/rubensilvab/Automatic-Detection-of-Ventricular-Fibrillation-through-Electrocardiogram/assets/130314085/cd525b6b-dc02-4fe6-8aad-f9d0b0f86be1">

**Figure 9.**          *The effect of using the window w(t) on the first segment of sinus rhythm for patient 1 (cu01).*

The next step is to convert this obtained segment into binary. That is, whenever a sample of our signal surpasses a certain threshold (V0), that sample will have the value of 1; on the contrary, if it does not exceed this threshold, the sample will have the value of 0.

<img width="1161" alt="Nm" src="https://github.com/rubensilvab/Automatic-Detection-of-Ventricular-Fibrillation-through-Electrocardiogram/assets/130314085/694f1dd5-dead-424e-b35b-858e4d8e0954">

**Figure 10.**          *Conversion of a normalized ECG segment with sinus rhythm (a) and with ventricular fibrillation (b) into binary after passing through the threshold V0 for patient 1 (cu01)*

Figure 18 clearly contrasts sinus rhythm and ventricular fibrillation. In (a), the binary signal is faint, with few samples surpassing V0, while in (b), during fibrillation, the binary signal is pronounced, with most samples exceeding V0. Hence, N(%) metric is notably higher during ventricular fibrillation.

#### F1 ratio

The last metric used is perhaps the most unconventional and less common compared to the metrics described earlier. This metric involves creating two graphs from the ECG data. The first graph aligns each sample with the next one, while the second graph aligns each sample with one five steps ahead.

<img width="1156" alt="f1ratio" src="https://github.com/rubensilvab/Automatic-Detection-of-Ventricular-Fibrillation-through-Electrocardiogram/assets/130314085/3f35ecda-5fb5-454e-81f9-5a3892662b64">

**Figure 10.**          *ECG graphs of patient 1 with ordinates advanced by 1 sample relative to the abscissas. ECG graphs of patient 1 with ordinates advanced by 5 samples relative to the abscissas.*

With this, the metric represented here is based on extracting features from these graphs, so to facilitate their study, the conversion of these figures into binary images is suggested as a new step in this method.

<img width="1092" alt="f1bin" src="https://github.com/rubensilvab/Automatic-Detection-of-Ventricular-Fibrillation-through-Electrocardiogram/assets/130314085/59e6cad7-dfb2-4a04-839a-b81efbb601a8">

**Figure 11.**          *Binary conversion of the ECG graphs of patient 1 with sinus and ventricular fibrillation rhythm, with ordinates advanced by 5 samples relative to the abscissas.*

Thus, metric F1 is obtained by subtracting the ratio of black pixels for the graph with 5 samples advanced (ratio 2) from the ratio of black pixels for the graph with 1 sample advanced (ratio 1).

Through the observation of these images, we once again perceive that areas of the ECG displaying ventricular fibrillation are denser. Therefore, it is expected that metric F1 will be higher for fibrillation areas.

### Selection of the appropriate window for metric calculation

We adopted a strategy to track metric evolution over time and ensure more precise calculations. By dividing the signals into fragments or windows, we can better analyze signal dynamics, reduce noise effects at boundaries, and mitigate leakage effects. These windows often overlap, providing continuity of information. We created windows with 50% overlap to fragment the signal and calculate metrics for each segment. We debated between window sizes of 7.5s and 10s. Opting for 10s windows ensured computational efficiency while capturing several heartbeats. The rejection of 7.5s windows was due to extraction and calculation challenges. Here's an illustrative example of window construction.

<img width="1163" alt="window" src="https://github.com/rubensilvab/Automatic-Detection-of-Ventricular-Fibrillation-through-Electrocardiogram/assets/130314085/03e7ff7a-8995-4286-be13-abcd0b7638db">

**Figure 12.**          *Example of window construction for the ECG without ventricular fibrillation for patient 1 (cu01).*

Therefore, for each window, the described metrics were calculated (except for N%, due to its own window).

### Individual metric evaluation

We'll analyze metric evolution over time for ECGs with and without ventricular fibrillation using boxplots. These graphical tools display data variation, providing key statistical measures and excluding outliers. Additionally, paired Wilcoxon signed rank tests in MATLAB will be conducted to confirm boxplot findings. The test assesses differences between paired samples' medians, with a significance level (α) of 5%. A p-value less than α rejects the null hypothesis, indicating significant differences (our goal).

#### Fundamental Frequency 

<img width="876" alt="freqfund" src="https://github.com/rubensilvab/Automatic-Detection-of-Ventricular-Fibrillation-through-Electrocardiogram/assets/130314085/be938d6d-5dc4-403d-9209-aa31696011f1">

**Figure 13.**          *Boxplot constructed using the medians for all patients of the Fundamental Frequencies and results of the hypothesis test*

Figure 13 suggests higher fundamental frequencies in fibrillation zones, with a median of 4 Hz compared to 2.5 Hz in non-anomalous ECGs. The p-value of 0.0079 (<0.05) from Table 4 confirms this difference, rejecting the hypothesis of equal medians.

#### Average Frequency 

<img width="1116" alt="averfreq" src="https://github.com/rubensilvab/Automatic-Detection-of-Ventricular-Fibrillation-through-Electrocardiogram/assets/130314085/89f14d2f-b474-429d-8311-1811f5216069">

**Figure 14.**          *Boxplot constructed using the medians for all patients of the Average Frequencies and results of the hypothesis test*

Figure 14 shows considerable overlap in mean frequency values across different zones studied. The analysis indicates no significant difference in medians (p-value > 0.05), rendering this metric unsuitable for discrimination in the project. Thus, we discard this metric from the classification process. 

#### Power 

<img width="1143" alt="power" src="https://github.com/rubensilvab/Automatic-Detection-of-Ventricular-Fibrillation-through-Electrocardiogram/assets/130314085/ec550341-ddf6-459e-99a7-d9bd346ca26d">

**Figure 15.**          *Boxplot constructed using the medians for all patients of the Power and results of the hypothesis test*

Figure 15 shows that the metric is not as linear as intended, still overlaps between conditions. Fibrillation ECGs show notably higher power values. P-value (<0.05) rejects equal medians hypothesis. While not ideal for discrimination, this metric may aid.

#### N(%)

<img width="1119" alt="n" src="https://github.com/rubensilvab/Automatic-Detection-of-Ventricular-Fibrillation-through-Electrocardiogram/assets/130314085/5fb05fe5-a93c-4dd8-ab3a-b855ab087edf">

**Figure 16.**          *Boxplot constructed using the medians for all patients of the N(%) and results of the hypothesis test*

As expected, Figure 16 shows significantly higher N(%) values for fibrillation zones with no overlap. This was predictable, as ventricular fibrillation episodes exhibit numerous oscillations compared to sinus rhythm. The p-value is much lower than 0.05, suggesting unequal medians for both cardiac conditions. Thus, this metric appears promising for cardiac pathology discrimination.

#### F1 Ratio

<img width="1133" alt="f1_ratio" src="https://github.com/rubensilvab/Automatic-Detection-of-Ventricular-Fibrillation-through-Electrocardiogram/assets/130314085/13c1ebb3-2231-4ad6-a71e-ef9ccdc0fdb4">

**Figure 17.**          *Boxplot constructed using the medians for all patients of the F1 metric and results of the hypothesis test*

Figure 17 analysis reveals minimal overlap between ECGs with and without ventricular fibrillation. Table confirms this, with a p-value much lower than 0.05, indicating different medians for both conditions. Consequently, metrics N(%) and F1 may be crucial for this project's primary objective, given their significantly lower p-values compared to others.

### Classification

The all process aimed to select metrics for discriminating between ventricular fibrillation and its absence. At this stage, we know that among all the selected metrics, average frequency is the one that does not proceed to classification. Two approaches, Unsupervised and Supervised Learning, are used for classification.

#### Unsupervised Approach 

In this final step, K-means model was employed to group ECG segments with and without fibrillation into distinct classes. We aggregated metrics into a [50x4] matrix, representing 25 participants with 2 ECG segments each. The model identifies two groups based on metrics' similarities. We aim to assess each metric's impact on distinguishing between groups by varying the dataset and using Min-Max Scaling for normalization.

<img width="1134" alt="metricev" src="https://github.com/rubensilvab/Automatic-Detection-of-Ventricular-Fibrillation-through-Electrocardiogram/assets/130314085/9ecf75bd-25d2-46a4-9aab-9c4bfe9d4f39">

**Figure 18.**          *Confusion matrix for the K-means model when using all metrics.*

Two key concepts in result evaluation for machine learning models are accuracy, the percentage of correct predictions, and sensitivity, the percentage of correctly predicted positive cases (ECGs with fibrillation). In clinical cases, it's more crucial for our model to correctly predict fibrillation to prevent and apply defibrillation.

#### Supervised Learning

In supervised learning, unlike unsupervised learning, the output of our dataset is known in advance. We aim to find a relationship between the selected metrics and the ECG state (ventricular fibrillation or not). We used the Random Forest model via Kaggle's Python server, working with non-normalized metrics, as the model is not sensitive to data normalization.

Additionally, out of the 50 ECG segments analyzed, the program selects 37 for training and the remaining 13 for validation. The results presented in the next chapter refer to the validation data.
In order to better evaluate our results, we adopted the strategy of running our classifier 15 times (with different train/validation data distributtion) and recording the mean and standard deviation of the results obtained. Below are two illustrative examples of the confusion matrix returned by the Python algorithm used.

<img width="1136" alt="exsl" src="https://github.com/rubensilvab/Automatic-Detection-of-Ventricular-Fibrillation-through-Electrocardiogram/assets/130314085/b1117fe9-3580-4cf0-920a-d56f79845c18">

**Figure 19.**          *Results obtained for the first usage (a) and second usage (b) of the random forest model when using all metrics.*

## Results 

Following the algorithm's development, we identified key metrics for discriminating between sinus rhythm and ventricular fibrillation. Using these metrics, we explored Unsupervised and Supervised Learning methods. In this chapter, we present and discuss the results obtained.

### Unsupervised Learning

<img width="1115" alt="rsul" src="https://github.com/rubensilvab/Automatic-Detection-of-Ventricular-Fibrillation-through-Electrocardiogram/assets/130314085/b0d52e8a-69c1-4269-b06d-12440e5c0124">

From the analysis of the presented Table 1, it's immediately apparent that power is entirely irrelevant as a metric when the other three metrics are present to aid in group formation.

**Table 1.**          *Results only for the use of the k-means model in unsupervised learning. Note: FF - fundamental frequency, Apenas - Only, Sem - without.*

Ultimately, two options emerge. N(%), F1, and FF together yield 90% accuracy, while N(%) alone sacrifices 2% accuracy for 100% sensitivity in detecting ventricular fibrillation, compared to 88% with all three metrics. Thus, relying solely on N(%) ensures 100% accuracy in detecting ventricular fibrillation, proving more efficient and computationally faster.

### Supervised Learning

<img width="1128" alt="rssl" src="https://github.com/rubensilvab/Automatic-Detection-of-Ventricular-Fibrillation-through-Electrocardiogram/assets/130314085/98020c37-6f49-4b27-bece-0ca4c053a807">

**Table 2.**          *Results from using the random forest model with all metrics and without using power for classification.*

Through Table 2 analysis, we find overall satisfactory results, with about 88% accuracy for both scenarios. Using all metrics, sensitivity reaches 92%, a 5% advantage over excluding power. While power has minimal impact, it aids fibrillation detection and shouldn't be overlooked. Additionally, the distinction between unsupervised and supervised learning approaches is apparent, with power being irrelevant in the former.

## Conclusion

- This study devised a novel algorithm for automatically detecting ventricular fibrillation (VF) using electrocardiogram (ECG) signals. Initially, signal preprocessing was conducted to enhance signal quality. Subsequently, five ECG characteristics were extracted through both temporal and spectral analyses, guided by existing literature. The constructed boxplots and hypothesis testing facilitated the evaluation of these metrics' discriminatory power for pathological conditions. Notably, the metric related to mean frequency was deemed inadequate and thus discarded, while metrics F1 and N(%) emerged as notable discriminators.

- For classification purposes, two distinct approaches were employed: Unsupervised Learning with the k-means model and Supervised Learning with random forests. In the Unsupervised Learning phase, the k-means model utilized a clustering technique to evaluate the impact of each metric on cluster formation. Results indicated that the N(%) metric played the most significant role, achieving 100% sensitivity when used alone, consistently grouping ECGs with pathology.

- In contrast, Supervised Learning with the random forests model showed promising results, achieving 92% sensitivity when utilizing all metrics. Notably, the model's performance improved when using all metrics together compared to the Unsupervised Learning approach.

- Overall, the study's findings were highly satisfactory and aligned with existing literature. Additionally, the study elucidated the advantages and disadvantages of using metrics together or separately, providing valuable insights for future research endeavors leveraging ECG characteristics for medical diagnosis and monitoring.


[^1]: Goldberger, A., L. Amaral, L. Glass, J. Hausdorff, P. C. Ivanov, R. Mark, J. E. Mietus, G. B. Moody, C. K. Peng, and H. E. Stanley. "PhysioBank, PhysioToolkit, and PhysioNet: Components of a new research resource for complex physiologic signals. Circulation [Online]. 101 (23), pp. e215–e220." (2000).
