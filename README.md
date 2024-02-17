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

The chosen database for this project is the CU Ventricular Tachyarrhythmia Database available on the Physionet website [^1]:. It comprises 35 ECGs from patients experiencing periods of ventricular tachycardia and ventricular fibrillation. Each ECG was sampled at 250 Hz for approximately 8.5 minutes, corresponding to 127,232 samples. The signals have been pre-processed with a second-order low-pass filter with a cutoff frequency of 70 Hz. Importantly, each subject's ECG includes annotations indicating the electrocardiogram's state, including episodes of ventricular fibrillation.

To ensure a balance between participant quantity and the number of samples with the pathology, a selection process was conducted. Twenty-five subjects were chosen, each with at least 10,000 samples (40 seconds) for each episode of fibrillation and without fibrillation (control group). This approach maintains a considerable number of participants while preserving essential ECG signal information.

### Preprocessing





[^1]: Goldberger, A., L. Amaral, L. Glass, J. Hausdorff, P. C. Ivanov, R. Mark, J. E. Mietus, G. B. Moody, C. K. Peng, and H. E. Stanley. "PhysioBank, PhysioToolkit, and PhysioNet: Components of a new research resource for complex physiologic signals. Circulation [Online]. 101 (23), pp. e215–e220." (2000).
